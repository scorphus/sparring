let new_tile left right = if left <> right then '^' else '.'

let determine_next_row current_row =
  let padded = "." ^ current_row ^ "." in
  String.init (String.length current_row) (fun i -> new_tile padded.[i] padded.[i + 2])

let count_safe row =
  let count = ref 0 in
  for i = 0 to String.length row - 1 do
    if row.[i] = '.' then incr count
  done;
  !count

let generate_rows initial_state total_rows =
  let rec aux row count remaining =
    if remaining = 0 then count
    else
      let next_row = determine_next_row row in
      aux next_row (count + count_safe next_row) (remaining - 1)
  in
  aux initial_state (count_safe initial_state) (total_rows - 1)

let () =
  let initial_state = read_line () in
  Printf.printf "Part 1: %d\n" (generate_rows initial_state 40);
  Printf.printf "Part 2: %d\n" (generate_rows initial_state 400000)
