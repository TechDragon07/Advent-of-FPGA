open! Core
open! Hardcaml
open! Day07_dune

let () =
  let scope = Scope.create () in
  let module Circuit = Circuit.With_interface (Day07.I) (Day07.O) in
  let circuit = Circuit.create_exn ~name:"day07_top" (Day07.create scope) in
  let database = Scope.circuit_database scope in
  Rtl.print ~database Verilog circuit
