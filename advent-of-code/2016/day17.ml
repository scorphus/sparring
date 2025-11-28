type doors = { up : bool; down : bool; left : bool; right : bool }

let is_open_char = function 'b' | 'c' | 'd' | 'e' | 'f' -> true | _ -> false

let is_open passcode path =
  let hash = Digest.string (passcode ^ path) |> Digest.to_hex in
  {
    up = is_open_char hash.[0];
    down = is_open_char hash.[1];
    left = is_open_char hash.[2];
    right = is_open_char hash.[3];
  }

let neighbors (x, y) passcode path =
  let doors = is_open passcode path in
  let candidates =
    [
      (doors.up && y > 0, (x, y - 1), path ^ "U");
      (doors.down && y < 3, (x, y + 1), path ^ "D");
      (doors.left && x > 0, (x - 1, y), path ^ "L");
      (doors.right && x < 3, (x + 1, y), path ^ "R");
    ]
  in
  List.filter_map (function true, pos, p -> Some (pos, p) | _ -> None) candidates

let bfs passcode =
  let start = (0, 0) in
  let goal = (3, 3) in
  let rec aux queue =
    match queue with
    | [] -> ""
    | (pos, path) :: rest -> if pos = goal then path else aux (rest @ neighbors pos passcode path)
  in
  aux [ (start, "") ]

let () =
  let passcode = match Sys.argv with [| _; s |] -> s | _ -> failwith "Usage: day17 <passcode>" in
  let shortest = bfs passcode in
  Printf.printf "Part 1: %s\n" shortest
