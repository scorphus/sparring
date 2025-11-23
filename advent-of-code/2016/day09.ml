let parse_op line =
  if String.length line = 0 then `End
  else
    try Scanf.sscanf line "(%dx%d)" (fun len n -> `Repeat (len, n))
    with Scanf.Scan_failure _ -> `Char (String.get line 0)

let read_file line =
  let rec aux line acc =
    match parse_op line with
    | `Repeat (len, n) ->
        let marker_len = String.length (Printf.sprintf "(%dx%d)" len n) in
        let data = String.sub line marker_len len in
        let rest = String.sub line (marker_len + len) (String.length line - marker_len - len) in
        aux rest (`Repeat (data, n, String.length data) :: acc)
    | `Char c ->
        let rest = String.sub line 1 (String.length line - 1) in
        aux rest (`Char :: acc)
    | `End -> List.rev acc
  in
  aux line []

let calc_length file =
  List.fold_left
    (fun acc item -> match item with
     | `Repeat (_, n, len) -> acc + (n * len)
     | `Char -> acc + 1)
    0 file

let rec calc_length_v2 file =
  List.fold_left
    (fun acc item -> match item with
     | `Repeat (file, n, _) -> acc + (n * calc_length_v2 (read_file file))
     | `Char -> acc + 1)
    0 file

let () =
  let line = read_line () in
  let file = read_file line  in
  let total_length = calc_length file in
  Printf.printf "Total decompressed length: %d\n" total_length;
  let total_length = calc_length_v2 file in
  Printf.printf "Total decompressed length v2: %d\n" total_length
