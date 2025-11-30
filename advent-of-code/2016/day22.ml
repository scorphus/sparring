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

let () =
  let cluster = read_cluster () in
  let part1 = count_viable_pairs cluster in
  Printf.printf "Part 1: %d\n" part1
