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
let rev_string s = String.init (String.length s) (fun i -> s.[String.length s - 1 - i])
let string_to_chars s = String.to_seq s |> List.of_seq
let digits_to_int digits = List.fold_left (fun acc d -> (acc * 10) + (Char.code d - Char.code '0')) 0 digits

let collect_idiotic char_cols =
  let rec aux cols current acc =
    match cols with
    | [] -> if current = [] then acc else List.rev current :: acc
    | col :: rest ->
        let digits = List.filter (fun c -> c <> ' ') col in
        if digits = [] then if current = [] then aux rest [] acc else aux rest [] (List.rev current :: acc)
        else aux rest (digits_to_int digits :: current) acc
  in
  aux char_cols [] []

let () =
  let lines = read_lines () in
  let ops = parse_tokens (List.hd lines) in
  let rows = List.map parse_row (List.tl lines) in
  let columns = transpose rows in
  let answers = List.map2 calc ops columns in
  Printf.printf "Part 1: %d\n" (add answers);
  (* Now the idiocy begins *)
  let lines_rev = List.map rev_string (List.tl lines) |> List.rev in
  let char_cols = List.map string_to_chars lines_rev |> transpose in
  let columns = collect_idiotic char_cols in
  let answers = List.map2 calc ops columns in
  Printf.printf "Part 2: %d\n" (add answers)
