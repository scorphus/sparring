let read_ranges () =
  let line = read_line () in
  let rec aux ranges acc =
    match ranges with
    | [] -> List.rev acc
    | h :: t ->
        let range =
          try Scanf.sscanf h "%d-%d" (fun a b -> (a, b)) with
          | Scanf.Scan_failure _ -> failwith ("Failed to parse range: " ^ h)
        in
        aux t (range :: acc)
  in
  aux (String.split_on_char ',' line) []

let is_invalid_silly id =
  let id_str = string_of_int id in
  if String.length id_str mod 2 = 1 then false
  else
    let mid = String.length id_str / 2 in
    String.sub id_str 0 mid = String.sub id_str mid mid

let is_invalid_sillier id =
  let s = string_of_int id in
  let n = String.length s in
  let rec check_period p =
    if p >= n then false
    else if n mod p <> 0 then check_period (p + 1)
    else
      let pattern = String.sub s 0 p in
      let rec matches i = if i >= n then true else if String.sub s i p = pattern then matches (i + p) else false in
      if matches p then true else check_period (p + 1)
  in
  check_period 1

let sum_invalid_ids checker ranges =
  List.fold_left
    (fun acc (a, b) ->
      acc
      + (List.init (b - a + 1) (fun i -> a + i)
        |> List.fold_left (fun sum id -> if checker id then sum + id else sum) 0))
    0 ranges

let () =
  let ranges = read_ranges () in
  Printf.printf "Part 1: %d\n" (sum_invalid_ids is_invalid_silly ranges);
  Printf.printf "Part 2: %d\n" (sum_invalid_ids is_invalid_sillier ranges)
