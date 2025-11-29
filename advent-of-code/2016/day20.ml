let parse_range line =
  try Scanf.sscanf line "%d-%d" (fun a b -> (a, b))
  with Scanf.Scan_failure _ -> failwith ("Failed to parse line: " ^ line)

let read_ranges () =
  let rec aux acc =
    try
      let line = read_line () in
      let range = parse_range line in
      aux (range :: acc)
    with End_of_file -> List.rev acc
  in
  aux []

let merge_ranges ranges =
  let sorted = List.sort (fun (a1, _) (a2, _) -> compare a1 a2) ranges in
  let rec aux merged = function
    | [] -> List.rev merged
    | (a, b) :: tail -> (
        match merged with
        | [] -> aux [ (a, b) ] tail
        | (ma, mb) :: mtail ->
            if a <= mb + 1 then
              let new_range = (ma, max mb b) in
              aux (new_range :: mtail) tail
            else aux ((a, b) :: merged) tail)
  in
  aux [] sorted

let () =
  let ranges = read_ranges () in
  let merged = merge_ranges ranges in
  let lowest_allowed = match merged with [] -> 0 | (_, b) :: _ -> b + 1 in
  Printf.printf "Part 1: %d\n" lowest_allowed
