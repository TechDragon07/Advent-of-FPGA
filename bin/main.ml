open! Core
open! Hardcaml
open! Day07_dune

let () =
  let scope = Scope.create () in
  (* Instantiate the Circuit functor with your interfaces *)
  let module Circuit = Circuit.With_interface (Day07.I) (Day07.O) in
  
  (* Create the circuit using the instantiated functor *)
  let circuit = Circuit.create_exn ~name:"day07_top" (Day07.create scope) in
  
  (* Retrieve the circuit database to handle hierarchical modules *)
  let database = Scope.circuit_database scope in
  
  (* Print the Verilog output using the database *)
  Rtl.print ~database Verilog circuit