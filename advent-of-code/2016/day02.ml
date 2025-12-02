let read_instructions () =
  let rec aux acc =
    try
      let line = read_line () in
      aux (line :: acc)
    with End_of_file -> List.rev acc
  in
  aux []

let run instructions state =
  String.fold_left
    (fun state instr ->
      match (instr, state) with
      | 'D', n when n < 7 -> state + 3
      | 'L', n when n > 1 && n <> 4 && n <> 7 -> state - 1
      | 'R', n when n < 9 && n <> 3 && n <> 6 -> state + 1
      | 'U', n when n > 3 -> state - 3
      | _, _ -> state)
    state instructions

let run_sequence instructions initial_state =
  List.fold_left
    (fun (state, acc) instr ->
      let state = run instr state in
      (state, state :: acc))
    (initial_state, []) instructions
  |> snd |> List.rev

let () =
  let instr = read_instructions () in
  let bathroom_code = run_sequence instr 5 in
  Printf.printf "Part 1: %s\n" (String.concat "" (List.map string_of_int bathroom_code))
