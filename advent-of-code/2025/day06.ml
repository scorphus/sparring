let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> acc
  in
  aux []

let parse_tokens line = String.split_on_char ' ' line |> List.filter (fun s -> s <> "")
let parse_row line = parse_tokens line |> List.map int_of_string

let rec transpose = function
  | [] :: _
  | [] ->
      []
  | rows -> List.map List.hd rows :: transpose (List.map List.tl rows)

let add numbers = List.fold_left ( + ) 0 numbers
let mul numbers = List.fold_left ( * ) 1 numbers
let calc op col = if op = "+" then add col else mul col

let () =
  let lines = read_lines () in
  let ops = parse_tokens (List.hd lines) in
  let rows = List.map parse_row (List.tl lines) in
  let columns = transpose rows in
  let answers = List.map2 calc ops columns in
  Printf.printf "Part 1: %d\n" (add answers)
