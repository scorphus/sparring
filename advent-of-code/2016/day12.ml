module InstrMap = Map.Make (Int)
module RegMap = Map.Make (String)

let read_code () =
  let rec aux code i =
    try
      let line = read_line () in
      let instr =
        match String.split_on_char ' ' line with
        | [ "cpy"; x; y ] -> ( match int_of_string_opt x with Some n -> `CpyN (n, y) | None -> `CpyR (x, y))
        | [ "inc"; x ] -> `Inc x
        | [ "dec"; x ] -> `Dec x
        | [ "jnz"; x; y ] -> (
            match (int_of_string_opt x, int_of_string_opt y) with
            | Some n, Some m -> `JnzN (n, m)
            | None, Some m -> `JnzR (x, m)
            | _ -> failwith ("Invalid jnz instruction: " ^ line))
        | _ -> failwith ("Unknown instruction: " ^ line)
      in
      aux (InstrMap.add i instr code) (i + 1)
    with End_of_file -> code
  in
  aux InstrMap.empty 0

let exec code regs =
  let rec aux regs i =
    let instr = InstrMap.find_opt i code in
    match instr with
    | None -> regs
    | Some instr -> (
        match instr with
        | `CpyN (n, y) -> aux (RegMap.add y n regs) (i + 1)
        | `CpyR (x, y) ->
            let value = match RegMap.find_opt x regs with Some v -> v | None -> 0 in
            aux (RegMap.add y value regs) (i + 1)
        | `Inc x ->
            let value = match RegMap.find_opt x regs with Some v -> v + 1 | None -> 1 in
            aux (RegMap.add x value regs) (i + 1)
        | `Dec x ->
            let value = match RegMap.find_opt x regs with Some v -> v - 1 | None -> -1 in
            aux (RegMap.add x value regs) (i + 1)
        | `JnzN (n, y) -> if n <> 0 then aux regs (i + y) else aux regs (i + 1)
        | `JnzR (x, y) ->
            let x_value = match RegMap.find_opt x regs with Some v -> v | None -> 0 in
            if x_value <> 0 then aux regs (i + y) else aux regs (i + 1))
  in
  aux regs 0

let () =
  let code = read_code () in
  let regs = exec code RegMap.empty in
  (match RegMap.find_opt "a" regs with
  | Some a -> Printf.printf "Part 1: %d\n" a
  | None -> failwith "Register a not found");
  let regs = exec code (RegMap.add "c" 1 RegMap.empty) in
  match RegMap.find_opt "a" regs with
  | Some a -> Printf.printf "Part 2: %d\n" a
  | None -> failwith "Register a not found"
