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

let tsp_held_karp distances poi_count =
  let full_mask = (1 lsl poi_count) - 1 in
  let dp = Array.make_matrix (1 lsl poi_count) poi_count max_int in
  dp.(1).(0) <- 0;
  for mask = 1 to full_mask do
    for u = 0 to poi_count - 1 do
      if mask land (1 lsl u) <> 0 then
        for v = 0 to poi_count - 1 do
          if mask land (1 lsl v) <> 0 && u <> v then
            let prev_mask = mask land lnot (1 lsl u) in
            match PosMap.find_opt (v, u) distances with
            | Some dist when dp.(prev_mask).(v) < max_int ->
                dp.(mask).(u) <- min dp.(mask).(u) (dp.(prev_mask).(v) + dist)
            | _ -> ()
        done
    done
  done;
  let res = ref max_int in
  for u = 0 to poi_count - 1 do
    res := min !res dp.(full_mask).(u)
  done;
  !res

let () =
  let map = read_map () in
  let poi = get_points_of_interest map in
  let distances = List.fold_left (fun acc (pos, _) -> bfs map pos acc) PosMap.empty poi in
  let poi_count = List.length poi in
  let part1 = tsp_held_karp distances poi_count in
  Printf.printf "Part 1: %d\n" part1
