let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> List.rev acc
  in
  aux []

let parse_tile line =
  match String.split_on_char ',' line |> List.map int_of_string with
  | [ x; y ] -> (x, y)
  | _ -> failwith "invalid tile"

let area (x1, y1) (x2, y2) = (abs (x2 - x1) + 1) * (abs (y2 - y1) + 1)

let max_area tiles =
  let rec aux largest = function
    | [] -> largest
    | tu :: rest ->
        let largest = List.fold_left (fun largest tv -> max largest (area tu tv)) largest rest in
        aux largest rest
  in
  aux 0 tiles

let () =
  let tiles = read_lines () |> List.map parse_tile in
  Printf.printf "Part 1: %d\n" (max_area tiles)
