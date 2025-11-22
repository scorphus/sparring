#load "str.cma"

let rec part1 seq x y dx dy =
  match seq with
  | [] -> Int.abs x + Int.abs y
  | head :: tail ->
      let turn = String.get head 0 in
      let dist = int_of_string (String.sub head 1 (String.length head - 1)) in
      let dx, dy = match turn with 'R' -> (dy, -dx) | _ -> (-dy, dx) in
      let x = x + (dx * dist) in
      let y = y + (dy * dist) in
      part1 tail x y dx dy

module LocationSet = Set.Make (struct
  type t = int * int

  let compare = compare (* uses built-in polymorphic compare *)
end)

let rec part2 seq x y dist dx dy locations =
  match dist with
  | 0 -> (
      match seq with
      | [] -> Int.abs x + Int.abs y
      | head :: tail ->
          let turn = String.get head 0 in
          let dist = int_of_string (String.sub head 1 (String.length head - 1)) in
          let dx, dy = match turn with 'R' -> (dy, -dx) | _ -> (-dy, dx) in
          part2 tail x y dist dx dy locations)
  | _ -> (
      let x = x + dx in
      let y = y + dy in
      let location = (x, y) in
      match LocationSet.mem location locations with
      | true -> Int.abs x + Int.abs y
      | false -> part2 seq x y (dist - 1) dx dy (LocationSet.add location locations))

let () =
  let line = read_line () in
  let seq = Str.split (Str.regexp ", ") line in
  let blocks = part1 seq 0 0 0 1 in
  Printf.printf "Part 1: %d\n" blocks;
  let blocks = part2 seq 0 0 0 0 1 LocationSet.empty in
  Printf.printf "Part 2: %d\n" blocks
