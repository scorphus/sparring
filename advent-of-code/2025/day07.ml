module IntMap = Map.Make (Int)

let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> List.rev acc
  in
  aux []

let find_start line = String.index line 'S'
let add_to_map col count map = IntMap.update col (fun c -> Some (Option.value c ~default:0 + count)) map
let sum_values map = IntMap.fold (fun _ c acc -> acc + c) map 0

let split_beams line beams =
  IntMap.fold
    (fun col count (beams, splits) ->
      if line.[col] = '^' then (beams |> add_to_map (col - 1) count |> add_to_map (col + 1) count, splits + 1)
      else (beams |> add_to_map col count, splits))
    beams (IntMap.empty, 0)

let simulate lines start_beam =
  List.fold_left
    (fun (beams, splits) line ->
      let beams, splits_in_line = split_beams line beams in
      (beams, splits + splits_in_line))
    (IntMap.empty |> IntMap.add start_beam 1, 0)
    lines

let () =
  let lines = read_lines () in
  let start_beam = find_start (List.hd lines) in
  let beams, splits = simulate (List.tl lines) start_beam in
  Printf.printf "Part 1: %d\n" splits;
  Printf.printf "Part 2: %d\n" (sum_values beams)
