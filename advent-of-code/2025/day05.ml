let parse_range line = Scanf.sscanf line "%d-%d" (fun a b -> (a, b))
let parse_id line = Scanf.sscanf line "%d" (fun id -> id)

let read parser =
  let rec aux acc =
    try aux ((read_line () |> parser) :: acc) with
    | _ -> acc
  in
  aux []

let merge_ranges ranges =
  List.sort compare ranges
  |> List.fold_left
       (fun acc (a, b) ->
         match acc with
         | (ma, mb) :: rest when a <= mb + 1 -> (ma, max mb b) :: rest
         | _ -> (a, b) :: acc)
       []
  |> List.rev

let is_fresh id range = List.exists (fun (a, b) -> a <= id && id <= b) range

let () =
  let ranges = read parse_range in
  let ids = read parse_id in
  let merged = merge_ranges ranges in
  Printf.printf "Part 1: %d\n" (List.filter (fun id -> is_fresh id merged) ids |> List.length);
  Printf.printf "Part 2: %d\n" (List.fold_left (fun acc (a, b) -> acc + (b - a + 1)) 0 merged)
