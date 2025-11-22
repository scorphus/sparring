let parse_op line =
  try Scanf.sscanf line "rect %dx%d" (fun width height -> `Rect (width, height))
  with Scanf.Scan_failure _ -> (
    try Scanf.sscanf line "rotate row y=%d by %d" (fun idx amt -> `RotR (idx, amt))
    with Scanf.Scan_failure _ -> Scanf.sscanf line "rotate column x=%d by %d" (fun idx amt -> `RotC (idx, amt)))

let read_card () =
  let rec aux acc =
    try
      let line = read_line () in
      aux (parse_op line :: acc)
    with End_of_file -> List.rev acc
  in
  aux []

let rec_t width height screen =
  for y = 0 to height - 1 do
    for x = 0 to width - 1 do
      screen.(y).(x) <- true
    done
  done

let rot_r idx amt screen =
  let width = Array.length screen.(0) in
  let new_row = Array.make width false in
  for x = 0 to width - 1 do
    new_row.((x + amt) mod width) <- screen.(idx).(x)
  done;
  screen.(idx) <- new_row

let rot_c idx amt screen =
  let height = Array.length screen in
  let new_col = Array.make height false in
  for y = 0 to height - 1 do
    new_col.((y + amt) mod height) <- screen.(y).(idx)
  done;
  for y = 0 to height - 1 do
    screen.(y).(idx) <- new_col.(y)
  done

let swipe card height width =
  let rec aux ops screen =
    match ops with
    | [] -> screen
    | head :: tail ->
        (match head with
        | `Rect (width, height) -> rec_t width height screen
        | `RotR (idx, amt) -> rot_r idx amt screen
        | `RotC (idx, amt) -> rot_c idx amt screen);
        aux tail screen
  in
  aux card (Array.make_matrix height width false)

let () =
  let height, width =
    match Sys.argv with
    | [| _; height; width |] ->
        let height = int_of_string height in
        let width = int_of_string width in
        (height, width)
    | _ -> failwith "Usage: day08 <height> <width>"
  in
  let card = read_card () in
  let screen = swipe card height width in
  let count = ref 0 in
  for y = 0 to Array.length screen - 1 do
    for x = 0 to Array.length screen.(0) - 1 do
      if screen.(y).(x) then (
        count := !count + 1;
        Printf.printf "█")
      else Printf.printf "░"
    done;
    Printf.printf "\n"
  done;
  Printf.printf "Total lit pixels: %d\n" !count
