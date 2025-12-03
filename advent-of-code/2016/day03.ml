let parse_triangle line = Scanf.sscanf line " %d %d %d" (fun a b c -> (a, b, c))

let read_triangles () =
  let rec aux acc = try aux ((read_line () |> parse_triangle) :: acc) with End_of_file -> acc in
  aux []

let is_valid_triangle (a, b, c) = a + b > c && a + c > b && b + c > a

let count_valid_triangles triangles =
  List.fold_left (fun acc triangle -> if is_valid_triangle triangle then acc + 1 else acc) 0 triangles

let count_valid_vertical triangles =
  let valid t = if is_valid_triangle t then 1 else 0 in
  let rec aux acc = function
    | (a1, b1, c1) :: (a2, b2, c2) :: (a3, b3, c3) :: tail ->
        aux (acc + valid (a1, a2, a3) + valid (b1, b2, b3) + valid (c1, c2, c3)) tail
    | _ -> acc
  in
  aux 0 triangles

let () =
  let triangle_sides = read_triangles () in
  Printf.printf "Part 1: %d\n" (count_valid_triangles triangle_sides);
  Printf.printf "Part 2: %d\n" (count_valid_vertical triangle_sides)
