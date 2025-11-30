let parse_op line =
  try Scanf.sscanf line "swap position %d with position %d" (fun x y -> `SwapPosition (x, y))
  with Scanf.Scan_failure _ -> (
    try Scanf.sscanf line "swap letter %c with letter %c" (fun x y -> `SwapLetter (x, y))
    with Scanf.Scan_failure _ -> (
      try Scanf.sscanf line "rotate left %d step%s" (fun x _ -> `RotateLeft x)
      with Scanf.Scan_failure _ -> (
        try Scanf.sscanf line "rotate right %d step%s" (fun x _ -> `RotateRight x)
        with Scanf.Scan_failure _ -> (
          try Scanf.sscanf line "rotate based on position of letter %c" (fun x -> `RotateBased x)
          with Scanf.Scan_failure _ -> (
            try Scanf.sscanf line "reverse positions %d through %d" (fun x y -> `Reverse (x, y))
            with Scanf.Scan_failure _ -> (
              try Scanf.sscanf line "move position %d to position %d" (fun x y -> `Move (x, y))
              with Scanf.Scan_failure _ -> failwith ("Failed to parse line: " ^ line)))))))

let read_ops () =
  let rec aux acc =
    try
      let line = read_line () in
      let op = parse_op line in
      aux (op :: acc)
    with End_of_file -> List.rev acc
  in
  aux []

let swap_position string x y =
  String.init (String.length string) (fun i -> if i = x then string.[y] else if i = y then string.[x] else string.[i])

let swap_letter string x y =
  let idx_x = String.index string x in
  let idx_y = String.index string y in
  swap_position string idx_x idx_y

let rotate_left string x =
  let n = String.length string in
  let x = x mod n in
  String.init n (fun i -> string.[(i + x) mod n])

let rotate_right string x =
  let n = String.length string in
  rotate_left string (n - (x mod n))

let rotate_based string x =
  let idx = String.index string x in
  let steps = 1 + idx + if idx >= 4 then 1 else 0 in
  rotate_right string steps

let reverse_positions string x y =
  String.init (String.length string) (fun i -> if i < x || i > y then string.[i] else string.[y - (i - x)])

let move_position string x y =
  let char_at_x = string.[x] in
  let without_x = String.init (String.length string - 1) (fun i -> if i < x then string.[i] else string.[i + 1]) in
  String.init (String.length string) (fun i ->
      if i < y then without_x.[i] else if i = y then char_at_x else without_x.[i - 1])

let run_ops operations string =
  List.fold_left
    (fun s op ->
      match op with
      | `SwapPosition (x, y) -> swap_position s x y
      | `SwapLetter (x, y) -> swap_letter s x y
      | `RotateLeft x -> rotate_left s x
      | `RotateRight x -> rotate_right s x
      | `RotateBased x -> rotate_based s x
      | `Reverse (x, y) -> reverse_positions s x y
      | `Move (x, y) -> move_position s x y)
    string operations

let () =
  let start = match Sys.argv with [| _; start |] -> start | _ -> failwith "Usage: day21 <start>" in
  let operations = read_ops () in
  let result = run_ops operations start in
  Printf.printf "Part 1: %s\n" result
