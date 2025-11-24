#load "str.cma"

let parse_floor line =
  let re = Str.regexp "\\([a-z]+\\)\\(-compatible\\)? \\(microchip\\|generator\\)" in
  let rec aux pos acc =
    try
      let _ = Str.search_forward re line pos in
      aux (Str.match_end ()) (acc + 1)
    with Not_found -> acc
  in
  aux 0 0

let read_arrangement () =
  let rec aux floors =
    try
      let line = read_line () in
      let items = parse_floor line in
      if items = 0 then aux floors else aux (items :: floors)
    with End_of_file -> List.rev floors
  in
  aux []

let count_stems arrangement =
  let steps, _ =
    List.fold_left (fun (steps, acc) items -> (steps + (2 * (acc + items - 1)) - 1, acc + items)) (0, 0) arrangement
  in
  steps

let () =
  let arrangement = read_arrangement () in
  let steps = count_stems arrangement in
  Printf.printf "Part 1: %d\n" steps;
  let arrangement =
    match arrangement with
    | first :: tail ->
        let new_first = 4 + first in
        new_first :: tail
    | [] -> failwith "invalid arrangement"
  in
  let steps = count_stems arrangement in
  Printf.printf "Part 2: %d\n" steps
