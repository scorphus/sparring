#load "str.cma"

module LetterMap = Map.Make (struct
  type t = char

  let compare = compare
end)

let parse_room line =
  let re = Str.regexp {|\(.*\)-\([0-9]+\)\[\([a-z]+\)\]|} in
  if Str.string_match re line 0 then
    let name = Str.matched_group 1 line in
    let sector_id = int_of_string (Str.matched_group 2 line) in
    let checksum = Str.matched_group 3 line in
    (name, sector_id, checksum)
  else failwith ("Failed to parse line: " ^ line)

let read_rooms () =
  let rec aux acc = try aux ((read_line () |> parse_room) :: acc) with End_of_file -> List.rev acc in
  aux []

let count_letter acc c = LetterMap.update c (fun v -> Some (Option.value ~default:0 v + 1)) acc

let is_real_room (name, _, checksum) =
  let letters = Str.global_replace (Str.regexp "-") "" name in
  let letter_counts = String.fold_left count_letter LetterMap.empty letters in
  LetterMap.bindings letter_counts
  |> List.map (fun (c, count) -> (-count, c))
  |> List.sort compare |> List.to_seq |> Seq.take 5 |> Seq.map snd |> String.of_seq = checksum

let real_rooms_id_sum rooms =
  rooms |> List.filter is_real_room |> List.map (fun (_, sector_id, _) -> sector_id) |> List.fold_left ( + ) 0

let () =
  let rooms = read_rooms () in
  Printf.printf "Part 1: %d\n" (real_rooms_id_sum rooms)
