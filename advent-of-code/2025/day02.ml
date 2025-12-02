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

let is_invalid id =
  let id_str = string_of_int id in
  if String.length id_str mod 2 = 1 then false
  else
    let mid = String.length id_str / 2 in
    String.sub id_str 0 mid = String.sub id_str mid mid

let sum_invalid_ids ranges =
  List.fold_left
    (fun acc (a, b) ->
      acc
      + (List.init (b - a + 1) (fun i -> a + i)
        |> List.fold_left (fun sum id -> if is_invalid id then sum + id else sum) 0))
    0 ranges

let () =
  let ranges = read_ranges () in
  Printf.printf "Part 1: %d\n" (sum_invalid_ids ranges)
