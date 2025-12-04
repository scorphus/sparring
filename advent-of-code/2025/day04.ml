module CoordSet = Set.Make (struct
  type t = int * int

  let compare = compare
end)

let read_grid () =
  let rec aux r acc =
    try
      read_line () |> String.to_seqi
      |> Seq.fold_left (fun set (c, ch) -> if ch = '@' then CoordSet.add (r, c) set else set) acc
      |> aux (r + 1)
    with
    | End_of_file -> acc
  in
  aux 0 CoordSet.empty

let count_neighbors rolls (r, c) =
  let deltas = [ -1; 0; 1 ] in
  List.fold_left
    (fun acc dr ->
      List.fold_left (fun acc dc -> if CoordSet.mem (r + dr, c + dc) rolls then acc + 1 else acc) acc deltas)
    0 deltas

let accessible rolls = CoordSet.filter (fun coord -> count_neighbors rolls coord < 5) rolls

let rec remove_accessible rolls =
  let to_remove = accessible rolls in
  if CoordSet.is_empty to_remove then rolls else remove_accessible (CoordSet.diff rolls to_remove)

let () =
  let rolls = read_grid () in
  Printf.printf "Part 1: %d\n" (CoordSet.cardinal (accessible rolls));
  let remaining = remove_accessible rolls in
  Printf.printf "Part 2: %d\n" (CoordSet.cardinal rolls - CoordSet.cardinal remaining)
