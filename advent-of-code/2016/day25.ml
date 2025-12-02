let signal_length = 10

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
        | [ "out"; x ] -> ( match int_of_string_opt x with Some n -> `OutN n | None -> `OutR x)
        | _ -> failwith ("Unknown instruction: " ^ line)
      in
      aux (InstrMap.add i instr code) (i + 1)
    with End_of_file -> code
  in
  aux InstrMap.empty 0

let exec code regs =
  let get_reg regs x = RegMap.find_opt x regs |> Option.value ~default:0 in
  let rec aux regs i =
    let instr = InstrMap.find_opt i code in
    match instr with
    | None -> Seq.Nil
    | Some instr -> (
        match instr with
        | `CpyN (n, y) -> aux (RegMap.add y n regs) (i + 1)
        | `CpyR (x, y) -> aux (RegMap.add y (get_reg regs x) regs) (i + 1)
        | `Inc x -> aux (RegMap.add x (get_reg regs x + 1) regs) (i + 1)
        | `Dec x -> aux (RegMap.add x (get_reg regs x - 1) regs) (i + 1)
        | `JnzN (n, y) -> if n <> 0 then aux regs (i + y) else aux regs (i + 1)
        | `JnzR (x, y) -> if get_reg regs x <> 0 then aux regs (i + y) else aux regs (i + 1)
        | `OutN n -> Seq.Cons (n, fun () -> aux regs (i + 1))
        | `OutR x -> Seq.Cons (get_reg regs x, fun () -> aux regs (i + 1)))
  in
  fun () -> aux regs 0

let rec check_signal seq prev count =
  if count = 0 then true
  else match seq () with Seq.Nil -> false | Seq.Cons (v, seq) -> v <> prev && check_signal seq v (count - 1)

let rec find_lowest_initializer code =
  let rec aux a =
    let signal = exec code (RegMap.add "a" a RegMap.empty) in
    if check_signal signal 1 signal_length then a else aux (a + 1)
  in
  aux 0

let () = Printf.printf "Part 1: %d\n" (read_code () |> find_lowest_initializer)
