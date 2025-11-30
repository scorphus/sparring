module InstrMap = Map.Make (Int)
module RegMap = Map.Make (String)

let read_code () =
  let rec aux code i =
    try
      let line = read_line () in
      let instr =
        match String.split_on_char ' ' line with
        | [ "cpy"; x; y ] -> ( match int_of_string_opt x with Some n -> `CpyNR (n, y) | None -> `CpyRR (x, y))
        | [ "inc"; x ] -> `Inc x
        | [ "dec"; x ] -> `Dec x
        | [ "jnz"; x; y ] -> (
            match (int_of_string_opt x, int_of_string_opt y) with
            | Some n, Some m -> `JnzNN (n, m)
            | None, Some m -> `JnzRN (x, m)
            | Some n, None -> `JnzNR (n, y)
            | None, None -> `JnzRR (x, y))
        | [ "tgl"; x ] -> `Tgl x
        | _ -> failwith ("Unknown instruction: " ^ line)
      in
      aux (InstrMap.add i instr code) (i + 1)
    with End_of_file -> code
  in
  aux InstrMap.empty 0

let exec code regs =
  let get_reg regs x = match RegMap.find_opt x regs with Some v -> v | None -> 0 in
  let rec aux code regs i =
    match InstrMap.find_opt i code with
    | None -> regs
    | Some instr -> (
        match instr with
        | `CpyNN (x, y) -> aux code regs (i + 1)
        | `CpyNR (n, y) -> aux code (RegMap.add y n regs) (i + 1)
        | `CpyRN (x, m) -> aux code regs (i + 1)
        | `CpyRR (x, y) -> aux code (RegMap.add y (get_reg regs x) regs) (i + 1)
        | `Inc x -> aux code (RegMap.add x (get_reg regs x + 1) regs) (i + 1)
        | `Dec x -> aux code (RegMap.add x (get_reg regs x - 1) regs) (i + 1)
        | `JnzNN (n, m) -> if n <> 0 then aux code regs (i + m) else aux code regs (i + 1)
        | `JnzNR (n, y) -> if n <> 0 then aux code regs (i + get_reg regs y) else aux code regs (i + 1)
        | `JnzRN (x, m) -> if get_reg regs x <> 0 then aux code regs (i + m) else aux code regs (i + 1)
        | `JnzRR (x, y) -> if get_reg regs x <> 0 then aux code regs (i + get_reg regs y) else aux code regs (i + 1)
        | `Tgl x ->
            let target_idx = i + get_reg regs x in
            let new_instr =
              match InstrMap.find_opt target_idx code with
              | None -> None
              | Some instr -> (
                  match instr with
                  | `Inc x -> Some (`Dec x)
                  | `Dec x -> Some (`Inc x)
                  | `Tgl x -> Some (`Inc x)
                  | `JnzNN (n, m) -> Some (`CpyNN (n, m))
                  | `JnzRN (x, m) -> Some (`CpyRN (x, m))
                  | `JnzNR (n, y) -> Some (`CpyNR (n, y))
                  | `JnzRR (x, y) -> Some (`CpyRR (x, y))
                  | `CpyNN (n, m) -> Some (`JnzNN (n, m))
                  | `CpyRN (x, m) -> Some (`JnzRN (x, m))
                  | `CpyNR (n, y) -> Some (`JnzNR (n, y))
                  | `CpyRR (x, y) -> Some (`JnzRR (x, y)))
            in
            let new_code = match new_instr with None -> code | Some instr -> InstrMap.add target_idx instr code in
            aux new_code regs (i + 1))
  in
  aux code regs 0

let () =
  let code = read_code () in
  let regs = exec code (RegMap.add "a" 7 RegMap.empty) in
  Printf.printf "Part 1: %d\n" (RegMap.find "a" regs)
