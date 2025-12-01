let wall = -2
let empty = -1

module PosMap = Map.Make (struct
  type t = int * int

  let compare = compare
end)

let read_map () =
  let rec aux y map =
    try
      let line = read_line () in
      let rec aux_line x map =
        if x >= String.length line then map
        else
          (match String.get line x with
            | '#' -> PosMap.add (x, y) wall map
            | '.' -> PosMap.add (x, y) empty map
            | c -> PosMap.add (x, y) (int_of_char c - int_of_char '0') map)
          |> aux_line (x + 1)
      in
      aux_line 0 map |> aux (y + 1)
    with End_of_file -> map
  in
  aux 0 PosMap.empty

let get_points_of_interest map = PosMap.fold (fun pos v acc -> if v >= 0 then (pos, v) :: acc else acc) map []

let neighbors map (x, y) =
  let candidates = [ (x + 1, y); (x - 1, y); (x, y + 1); (x, y - 1) ] in
  List.filter (fun (nx, ny) -> PosMap.find (nx, ny) map <> wall) candidates

let bfs map start distances =
  let start_lbl =
    match PosMap.find_opt start map with
    | Some v when v >= 0 -> v
    | _ -> failwith "Start position is not a point of interest"
  in
  let rec aux queue visited distances =
    match queue with
    | [] -> distances
    | (pos, steps) :: rest ->
        let distances =
          match PosMap.find_opt pos map with
          | Some v when v >= 0 -> PosMap.add (start_lbl, v) steps distances
          | _ -> distances
        in
        let new_steps = steps + 1 in
        let neighbors = neighbors map pos |> List.filter (fun p -> not (PosMap.mem p visited)) in
        let new_visited = List.fold_left (fun acc p -> PosMap.add p () acc) visited neighbors in
        let new_queue = rest @ List.map (fun p -> (p, new_steps)) neighbors in
        aux new_queue new_visited distances
  in
  aux [ (start, 0) ] (PosMap.add start () PosMap.empty) distances

module DPMap = Map.Make (struct
  type t = int * int

  let compare = compare
end)

let try_from_node distances mask u dp v =
  if mask land (1 lsl v) = 0 || u = v then dp
  else
    let prev_mask = mask land lnot (1 lsl u) in
    match (PosMap.find_opt (v, u) distances, DPMap.find_opt (prev_mask, v) dp) with
    | Some dist, Some prev_dist ->
        let new_dist = prev_dist + dist in
        let current = DPMap.find_opt (mask, u) dp |> Option.value ~default:max_int in
        DPMap.add (mask, u) (min current new_dist) dp
    | _ -> dp

let best_path_to_node distances poi_count mask dp u =
  if mask land (1 lsl u) = 0 then dp
  else List.init poi_count Fun.id |> List.fold_left (try_from_node distances mask u) dp

let tsp_held_karp distances poi_count =
  let full_mask = (1 lsl poi_count) - 1 in
  List.init full_mask succ
  |> List.fold_left
       (fun dp mask -> List.init poi_count Fun.id |> List.fold_left (best_path_to_node distances poi_count mask) dp)
       (DPMap.add (1, 0) 0 DPMap.empty)

let part1 dp poi_count =
  let full_mask = (1 lsl poi_count) - 1 in
  List.init poi_count Fun.id
  |> List.filter_map (fun u -> DPMap.find_opt (full_mask, u) dp)
  |> List.fold_left min max_int

let part2 dp poi_count distances =
  let full_mask = (1 lsl poi_count) - 1 in
  List.init (poi_count - 1) succ
  |> List.filter_map (fun u ->
      match (DPMap.find_opt (full_mask, u) dp, PosMap.find_opt (u, 0) distances) with
      | Some dp_val, Some dist -> Some (dp_val + dist)
      | _ -> None)
  |> List.fold_left min max_int

let () =
  let map = read_map () in
  let poi = get_points_of_interest map in
  let distances = List.fold_left (fun acc (pos, _) -> bfs map pos acc) PosMap.empty poi in
  let poi_count = List.length poi in
  let dp = tsp_held_karp distances poi_count in
  let part1 = part1 dp poi_count in
  Printf.printf "Part 1: %d\n" part1;
  let part2 = part2 dp poi_count distances in
  Printf.printf "Part 2: %d\n" part2
