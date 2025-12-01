let dir_l = -1
let dir_r = 1
let dial_len = 100
let dial_start = 50

let parse_rotation line =
  try Scanf.sscanf line "L%d" (fun clicks -> (dir_l, clicks)) with
  | Scanf.Scan_failure _ -> (
      try Scanf.sscanf line "R%d" (fun clicks -> (dir_r, clicks)) with
      | Scanf.Scan_failure _ -> failwith ("Failed to parse line: " ^ line))

let rec read_rotations rotations =
  try
    let rotation = read_line () |> parse_rotation in
    read_rotations (rotation :: rotations)
  with
  | End_of_file -> List.rev rotations

let part_1 rotations =
  let _, zeros =
    List.fold_left
      (fun (state, zeros) (dir, clicks) ->
        let state = (state + (dir * clicks)) mod dial_len in
        (state, if state = 0 then zeros + 1 else zeros))
      (dial_start, 0) rotations
  in
  zeros

let rec apply_clicks state dir clicks zeros =
  if clicks = 0 then (state, zeros)
  else
    let state = (state + dir + dial_len) mod dial_len in
    apply_clicks state dir (clicks - 1) (if state = 0 then zeros + 1 else zeros)

let part_2 rotations =
  let _, zeros =
    List.fold_left (fun (state, zeros) (dir, clicks) -> apply_clicks state dir clicks zeros) (dial_start, 0) rotations
  in
  zeros

let () =
  let rotations = read_rotations [] in
  Printf.printf "Part 1: %d\n" (part_1 rotations);
  Printf.printf "Part 2: %d\n" (part_2 rotations)
