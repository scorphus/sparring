#load "str.cma"

let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> List.rev acc
  in
  aux []

let target_re = Str.regexp {|\[\([.#]+\)\]|}
let button_re = Str.regexp {|(\([0-9,]+\))|}

let parse_target line =
  if Str.string_match target_re line 0 then
    let s = Str.matched_group 1 line in
    String.fold_left
      (fun (i, mask) c ->
        let mask = if c = '#' then mask lor (1 lsl i) else mask in
        (i + 1, mask))
      (0, 0) s
    |> snd
  else failwith "no target found"

let parse_buttons line =
  let rec aux acc pos =
    try
      let _ = Str.search_forward button_re line pos in
      let s = Str.matched_group 1 line in
      let mask = String.split_on_char ',' s |> List.fold_left (fun m s -> m lor (1 lsl int_of_string s)) 0 in
      aux (mask :: acc) (Str.match_end ())
    with
    | Not_found -> List.rev acc
  in
  aux [] 0

let rec combinations k list =
  match (k, list) with
  | 0, _ -> [ [] ]
  | _, [] -> []
  | k, x :: xs ->
      let with_x = List.map (fun c -> x :: c) (combinations (k - 1) xs) in
      let without_x = combinations k xs in
      with_x @ without_x

let min_presses target buttons =
  let n = List.length buttons in
  let rec aux r =
    if r > n then n
    else if List.exists (fun combo -> List.fold_left ( lxor ) 0 combo = target) (combinations r buttons) then r
    else aux (r + 1)
  in
  aux 1

let () =
  let lines = read_lines () in
  let total = List.fold_left (fun acc line -> acc + min_presses (parse_target line) (parse_buttons line)) 0 lines in
  Printf.printf "Part 1: %d\n" total
