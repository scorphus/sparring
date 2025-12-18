module IntMap = Map.Make (Int)

module UnionFind = struct
  let create n =
    let rec aux acc i = if i >= n then acc else aux (IntMap.add i i acc) (i + 1) in
    aux IntMap.empty 0

  let rec find parent x =
    let px = IntMap.find x parent in
    if px = x then (parent, x) else find parent px

  let union parent x y =
    let parent, px = find parent x in
    let parent, py = find parent y in
    if px = py then parent else IntMap.add py px parent
end

let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> List.rev acc
  in
  aux []

let parse_point line = String.split_on_char ',' line |> List.map int_of_string
let sq_dist p1 p2 = List.fold_left2 (fun acc a b -> acc + ((a - b) * (a - b))) 0 p1 p2

let all_pairs points =
  let indexed = List.mapi (fun i p -> (i, p)) points in
  let rec aux acc = function
    | [] -> acc
    | (i, pi) :: rest ->
        let acc = List.fold_left (fun acc (j, pj) -> (sq_dist pi pj, i, j) :: acc) acc rest in
        aux acc rest
  in
  List.sort compare (aux [] indexed)

let take k lst =
  let rec aux acc k = function
    | [] -> List.rev acc
    | x :: xs -> if k = 0 then List.rev acc else aux (x :: acc) (k - 1) xs
  in
  aux [] k lst

let group_sizes parent n =
  let counts =
    List.init n Fun.id
    |> List.fold_left
         (fun acc i ->
           let _, root = UnionFind.find parent i in
           IntMap.update root (fun c -> Some (1 + Option.value c ~default:0)) acc)
         IntMap.empty
  in
  IntMap.fold (fun _ size acc -> size :: acc) counts [] |> List.sort (fun a b -> b - a)

let () =
  let n_connections =
    match Sys.argv with
    | [| _; n |] -> int_of_string n
    | _ -> failwith "Usage: day08 <n_connections>"
  in
  let points = read_lines () |> List.map parse_point in
  let pairs = all_pairs points in
  let n = List.length points in
  let parent =
    take n_connections pairs |> List.fold_left (fun parent (_, i, j) -> UnionFind.union parent i j) (UnionFind.create n)
  in
  let sizes = group_sizes parent n in
  let p1 = List.nth sizes 0 * List.nth sizes 1 * List.nth sizes 2 in
  Printf.printf "Part 1: %d\n" p1
