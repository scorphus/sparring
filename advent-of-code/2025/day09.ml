module IntMap = Map.Make (Int)

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

let horiz_segments tiles =
  let x2, y2 = List.hd tiles in
  let rec aux acc = function
    | [] -> acc
    | [ (x1, y1) ] -> if y1 = y2 then (y1, min x1 x2, max x1 x2) :: acc else acc
    | (x1, y1) :: ((x2, y2) :: _ as rest) ->
        let acc = if y1 = y2 then (y1, min x1 x2, max x1 x2) :: acc else acc in
        aux acc rest
  in
  aux [] tiles

let unique_xs tiles = tiles |> List.map fst |> List.sort_uniq compare

let pairs lst =
  let rec aux acc = function
    | a :: b :: rest -> aux ((a, b) :: acc) rest
    | _ -> acc
  in
  aux [] lst

let valid_ranges segments unique_xs =
  List.fold_left
    (fun acc x ->
      let ys =
        segments
        |> List.filter_map (fun (y, xlo, xhi) -> if xlo <= x && x < xhi then Some y else None)
        |> List.sort compare
      in
      match ys with
      | [] -> acc
      | _ -> IntMap.add x (pairs ys) acc)
    IntMap.empty unique_xs

let is_inside ranges unique_xs xlo xhi ylo yhi =
  let rec check = function
    | [] -> true
    | x :: rest -> (
        if x < xlo then check rest
        else if x > xhi then true
        else
          match IntMap.find_opt x ranges with
          | None -> false
          | Some rs -> if List.exists (fun (vlo, vhi) -> vlo <= ylo && yhi <= vhi) rs then check rest else false)
  in
  check unique_xs

let max_area tiles =
  let rec aux largest = function
    | [] -> largest
    | tu :: rest ->
        let largest = List.fold_left (fun largest tv -> max largest (area tu tv)) largest rest in
        aux largest rest
  in
  aux 0 tiles

let max_inside_area ranges unique_xs tiles =
  let rec aux largest = function
    | [] -> largest
    | (x1, y1) :: rest ->
        let largest =
          List.fold_left
            (fun largest (x2, y2) ->
              let xlo, xhi = if x1 <= x2 then (x1, x2) else (x2, x1) in
              let ylo, yhi = if y1 <= y2 then (y1, y2) else (y2, y1) in
              let a = area (xlo, ylo) (xhi, yhi) in
              if a > largest && is_inside ranges unique_xs xlo xhi ylo yhi then a else largest)
            largest rest
        in
        aux largest rest
  in
  aux 0 tiles

let () =
  let tiles = read_lines () |> List.map parse_tile in
  Printf.printf "Part 1: %d\n" (max_area tiles);
  let segments = horiz_segments tiles in
  let xs = unique_xs tiles in
  let ranges = valid_ranges segments xs in
  Printf.printf "Part 2: %d\n" (max_inside_area ranges xs tiles)
