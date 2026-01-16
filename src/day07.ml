open! Core
open! Hardcaml
open Signal

let ( ==:& ) a b = a ==:. Char.to_int b

module I = struct
  type 'a t = { clock : 'a; clear : 'a; rx_data : 'a [@bits 8]; rx_valid : 'a } [@@deriving hardcaml]
end

module O = struct
  type 'a t = { part1 : 'a [@bits 64]; part2 : 'a [@bits 64]; done_ : 'a } [@@deriving hardcaml]
end

let circular_buffer ~_scope ~spec ~data_in ~shift ~delay =
  let delay_bits = 12 in
  let write_addr = counter spec ~width:delay_bits ~enable:shift in
  let read_addr = write_addr -: (delay -:. 1) in
  Ram.create ~size:(1 lsl delay_bits) ~collision_mode:Write_before_read
    ~write_ports:[| 
      { write_clock = Reg_spec.clock spec; 
        write_data = data_in; 
        write_enable = shift; 
        write_address = write_addr } 
    |]
    ~read_ports:[| 
      { read_clock = Reg_spec.clock spec; 
        read_enable = shift; 
        read_address = read_addr } 
    |]
    () |> fun a -> a.(0)

let create scope (i : _ I.t) =
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  
  let make_window ~enable init =
    let r0 = reg spec ~enable init in
    let r1 = reg spec ~enable r0 in
    let r2 = reg spec ~enable r1 in
    [| r2; r1; r0 |]
  in

  let char_window = make_window ~enable:i.rx_valid i.rx_data in
  let counter_update = wire 48 in

  let row_above_data = circular_buffer ~_scope:scope ~spec ~data_in:counter_update ~shift:i.rx_valid ~delay:(of_int_trunc 100 ~width:12) in
  let count_window = make_window ~enable:i.rx_valid row_above_data in

  counter_update <-- (
    let base = mux2 (char_window.(1) ==:& 'S') (one 48) (
               mux2 (char_window.(1) ==:& '^') (zero 48) count_window.(1)) in
    let with_left  = mux2 (char_window.(0) ==:& '^') (base +: count_window.(0)) base in
    let with_right = mux2 (char_window.(2) ==:& '^') (with_left +: count_window.(2)) with_left in
    with_right
  );

  let part1 = counter spec ~width:64 ~enable:(i.rx_valid &: (char_window.(1) ==:& '^') &: (count_window.(1) <>:. 0)) in
  let part2 = reg_fb spec ~width:64 ~f:(fun cur -> cur +: uextend counter_update ~width:64) in

  { O.part1 = uextend part1 ~width:64; part2; done_ = gnd }
