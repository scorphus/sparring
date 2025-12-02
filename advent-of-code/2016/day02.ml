let read_instructions () =
  let rec aux acc =
    try
      let line = read_line () in
      aux (line :: acc)
    with End_of_file -> List.rev acc
  in
  aux []

let run_sequence instructions keypad initial_state =
  List.fold_left
    (fun (state, acc) instr ->
      let state = String.fold_left keypad state instr in
      (state, state :: acc))
    (initial_state, []) instructions
  |> snd |> List.rev

let keypad_9 state instr =
  match (instr, state) with
  | 'D', n when n < 7 -> state + 3
  | 'L', n when n > 1 && n <> 4 && n <> 7 -> state - 1
  | 'R', n when n < 9 && n <> 3 && n <> 6 -> state + 1
  | 'U', n when n > 3 -> state - 3
  | _, _ -> state

let keypad_13 state instr =
  match (instr, state) with
  | 'D', n when n = 1 || n = 11 -> state + 2
  | 'D', n when n > 1 && n < 9 && n <> 5 -> state + 4
  | 'L', n when n > 2 && n <> 5 && n <> 10 && n <> 13 -> state - 1
  | 'R', n when n > 1 && n <> 4 && n <> 9 && n < 12 -> state + 1
  | 'U', n when n = 3 || n = 13 -> state - 2
  | 'U', n when n > 5 && n < 13 && n <> 9 -> state - 4
  | _, _ -> state

let hex_of_int = Printf.sprintf "%X"

let () =
  let instr = read_instructions () in
  let bathroom_code = run_sequence instr keypad_9 5 in
  Printf.printf "Part 1: %s\n" (String.concat "" (List.map string_of_int bathroom_code));
  let bathroom_code = run_sequence instr keypad_13 5 in
  Printf.printf "Part 2: %s\n" (String.concat "" (List.map hex_of_int bathroom_code))
