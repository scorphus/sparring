let parse_node line =
  try Scanf.sscanf line "/dev/grid/node-x%d-y%d %dT %dT %dT%s" (fun x y size used avail _ -> (x, y, size, used, avail))
  with Scanf.Scan_failure _ -> failwith ("Failed to parse line: " ^ line)

let read_cluster () =
  (* who needs header lines: *)
  read_line () |> ignore;
  read_line () |> ignore;
  let rec aux acc =
    try
      let line = read_line () in
      aux (parse_node line :: acc)
    with End_of_file -> List.rev acc
  in
  aux []

let rec get_action_and_count u a used avail count =
  let ux, uy, usize, uused, uavail = u in
  let ax, ay, asize, aused, aavail = a in
  if uused = 0 then `DropU count
  else if ux = ax && uy = ay then
    if avail = [] then `DropU count else get_action_and_count u (List.hd avail) used (List.tl avail) count
  else if uused <= aavail then
    if avail = [] then `DropU (count + 1) else get_action_and_count u (List.hd avail) used (List.tl avail) (count + 1)
  else `DropA count

let count_viable_pairs cluster =
  let rec aux used avail count =
    match (used, avail) with
    | [], _ -> count
    | _, [] -> count
    | u :: used_t, a :: avail_t -> (
        match get_action_and_count u a used_t avail_t count with
        | `DropU new_count -> aux used_t avail new_count
        | `DropA new_count -> if new_count = count then aux used avail_t new_count else aux used_t avail new_count)
  in
  aux
    (List.sort (fun (_, _, _, used1, _) (_, _, _, used2, _) -> compare used1 used2) cluster)
    (List.sort (fun (_, _, _, _, avail1) (_, _, _, _, avail2) -> compare avail1 avail2) cluster)
    0

let count_viable_pairs_naive cluster =
  List.fold_left
    (fun count a ->
      List.fold_left
        (fun count b ->
          let ax, ay, _, aused, _ = a in
          let bx, by, _, _, bavail = b in
          if aused > 0 && (ax <> bx || ay <> by) && aused <= bavail then count + 1 else count)
        count cluster)
    0 cluster

let show_cluster cluster =
  let max_x = List.fold_left (fun acc (x, _, _, _, _) -> max acc x) 0 cluster in
  List.iter (fun x -> Printf.printf "    |     %2d" x) (List.init (max_x + 1) (fun x -> x));
  List.iter
    (fun (x, y, size, used, avail) ->
      Printf.printf "%s%3dT/%3dT" (if x = 0 then Printf.sprintf "\n %2d | " y else " | ") size used)
    (List.sort (fun (x1, y1, _, _, _) (x2, y2, _, _, _) -> compare (y1, x1) (y2, x2)) cluster)

let part_2 cluster =
  let steps_to_shift = 5 in
  let max_x, max_y = List.fold_left (fun (mx, my) (x, y, _, _, _) -> (max mx x, max my y)) (0, 0) cluster in
  let empty_x, empty_y, empty_size, _, _ = List.find (fun (_, _, _, used, _) -> used = 0) cluster in
  let rightmost_passage_x =
    List.fold_left (fun acc (x, _, _, used, _) -> if used > empty_size then min acc x else acc) empty_x cluster - 1
  in
  empty_x + empty_y - (2 * rightmost_passage_x) + max_x + ((max_x - 1) * steps_to_shift)

let () =
  let cluster = read_cluster () in
  let start = Sys.time () in
  let part1 = count_viable_pairs cluster in
  Printf.printf "Part 1: %d (computed in %.6f seconds)\n" part1 (Sys.time () -. start);
  let part1_naive = count_viable_pairs_naive cluster in
  Printf.printf "Part 1 (naive): %d (computed in %.6f seconds)\n" part1_naive (Sys.time () -. start);
  Printf.printf "Part 2: %d\n" (part_2 cluster)
