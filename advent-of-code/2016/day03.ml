let parse_triangle line = Scanf.sscanf line " %d %d %d" (fun a b c -> (a, b, c))

let read_triangles () =
  let rec aux acc = try aux ((read_line () |> parse_triangle) :: acc) with End_of_file -> acc in
  aux []

let is_valid_triangle (a, b, c) = a + b > c && a + c > b && b + c > a

let count_valid_triangles triangles =
  List.fold_left (fun acc triangle -> if is_valid_triangle triangle then acc + 1 else acc) 0 triangles

let () =
  let triangle_sides = read_triangles () in
  Printf.printf "Part 1: %d\n" (count_valid_triangles triangle_sides)
