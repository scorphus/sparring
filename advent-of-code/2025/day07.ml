module IntSet = Set.Make (Int)

let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> List.rev acc
  in
  aux []

let find_start line = String.index line 'S'

let split_beams line beams =
  IntSet.fold
    (fun i (beams, splits) ->
      if line.[i] = '^' then (beams |> IntSet.add (i - 1) |> IntSet.add (i + 1), splits + 1)
      else (beams |> IntSet.add i, splits))
    beams (IntSet.empty, 0)

let count_splits lines start_beam =
  List.fold_left
    (fun (beams, splits) line ->
      let beams, splits_in_line = split_beams line beams in
      (beams, splits + splits_in_line))
    (IntSet.empty |> IntSet.add start_beam, 0)
    lines

let () =
  let lines = read_lines () in
  let start_beam = find_start (List.hd lines) in
  let _, splits = count_splits (List.tl lines) start_beam in
  Printf.printf "Part 1: %d\n" splits
