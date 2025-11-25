module Coord = struct
  type t = int * int

  let compare = compare
end

module CoordSet = Set.Make (Coord)

let equation x y = (x * x) + (3 * x) + (2 * x * y) + y + (y * y)
let rec count_ones n = if n = 0 then 0 else (n land 1) + count_ones (n lsr 1)
let is_open_space fave_number x y = count_ones (equation x y + fave_number) mod 2 = 0

let reach fave_number target =
  let rec aux queue visited locations =
    match queue with
    | [] -> (-1, [])
    | ((x, y), steps) :: rest ->
        let locations = ((x, y), steps) :: locations in
        if (x, y) = target then (steps, locations)
        else
          let new_steps = steps + 1 in
          let neighbors =
            [ ((x + 1, y), new_steps); ((x - 1, y), new_steps); ((x, y + 1), new_steps); ((x, y - 1), new_steps) ]
            |> List.filter (fun ((nx, ny), _) -> nx >= 0 && ny >= 0)
            |> List.filter (fun ((nx, ny), _) -> is_open_space fave_number nx ny)
            |> List.filter (fun (coord, _) -> not (CoordSet.mem coord visited))
          in
          let new_visited = List.fold_left (fun acc (coord, _) -> CoordSet.add coord acc) visited neighbors in
          aux (rest @ neighbors) new_visited locations
  in
  aux [ ((1, 1), 0) ] (CoordSet.singleton (1, 1)) []

let () =
  let fave_number, target =
    match Sys.argv with
    | [| _; num; x; y |] -> (int_of_string num, (int_of_string x, int_of_string y))
    | _ -> failwith "Usage: day13 <fave_number> <target_x> <target_y>"
  in
  let steps, locations = reach fave_number target in
  Printf.printf "Part 1: %d\n" steps;
  let part2 = List.fold_left (fun acc ((_, _), steps) -> if steps <= 50 then acc + 1 else acc) 0 locations in
  Printf.printf "Part 2: %d\n" part2
