module CharMap = Map.Make (Char)

let read_messages () =
  let rec aux acc =
    try aux ((read_line () |> String.to_seq |> List.of_seq) :: acc) with End_of_file -> List.rev acc
  in
  aux []

let rec transpose = function [] :: _ | [] -> [] | rows -> List.map List.hd rows :: transpose (List.map List.tl rows)

let count_chars chars =
  let counts =
    List.fold_left
      (fun acc c -> CharMap.update c (fun v -> Some (Option.value ~default:0 v + 1)) acc)
      CharMap.empty chars
  in
  CharMap.bindings counts

let most_frequent char_freqs =
  List.fold_left
    (fun (max_c, max_count) (c, count) -> if count > max_count then (c, count) else (max_c, max_count))
    ('!', 0) char_freqs
  |> fst

let least_frequent char_freqs =
  List.fold_left
    (fun (min_c, min_count) (c, count) -> if count < min_count then (c, count) else (min_c, min_count))
    ('!', max_int) char_freqs
  |> fst

let () =
  let messages = read_messages () in
  let transposed = transpose messages in
  let char_freqs = List.map count_chars transposed in
  let part1 = List.map most_frequent char_freqs |> List.to_seq |> String.of_seq in
  Printf.printf "Part 1: %s\n" part1;
  let part2 = List.map least_frequent char_freqs |> List.to_seq |> String.of_seq in
  Printf.printf "Part 2: %s\n" part2
