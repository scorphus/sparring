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
        aux rest (`Repeat (String.make 1 c, 1, 1) :: acc)
    | `End -> List.rev acc
  in
  aux (read_line ()) []

let () =
  let file = read_file () in
  let total_length = List.fold_left (fun acc (`Repeat (_, n, len)) -> acc + (n * len)) 0 file in
  Printf.printf "Total decompressed length: %d\n" total_length
