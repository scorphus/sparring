#load "str.cma"

#use "frac.ml"

let read_lines () =
  let rec aux acc =
    try aux (read_line () :: acc) with
    | End_of_file -> List.rev acc
  in
  aux []

let lights_re = Str.regexp {|\[\([.#]+\)\]|}
let button_re = Str.regexp {|(\([0-9,]+\))|}
let joltage_re = Str.regexp {|{\([0-9,]+\)}|}

let parse_lights line =
  Str.search_forward lights_re line 0 |> ignore;
  let s = Str.matched_group 1 line in
  String.fold_left
    (fun (i, mask) c ->
      let mask = if c = '#' then mask lor (1 lsl i) else mask in
      (i + 1, mask))
    (0, 0) s
  |> snd

let parse_toggles line =
  let rec aux acc pos =
    try
      Str.search_forward button_re line pos |> ignore;
      let s = Str.matched_group 1 line in
      let mask = String.split_on_char ',' s |> List.fold_left (fun m s -> m lor (1 lsl int_of_string s)) 0 in
      aux (mask :: acc) (Str.match_end ())
    with
    | Not_found -> List.rev acc
  in
  aux [] 0

let parse_joltage line =
  Str.search_forward joltage_re line 0 |> ignore;
  Str.matched_group 1 line |> String.split_on_char ',' |> List.map int_of_string

let parse_increments line =
  let rec aux acc pos =
    try
      Str.search_forward button_re line pos |> ignore;
      let indices = Str.matched_group 1 line |> String.split_on_char ',' |> List.map int_of_string in
      aux (indices :: acc) (Str.match_end ())
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

let build_matrix increments joltage =
  List.mapi
    (fun row target ->
      List.map (fun btn -> Frac.of_int (if List.mem row btn then 1 else 0)) increments @ [ Frac.of_int target ])
    joltage

let sub_rows row1 row2 factor = List.map2 (fun a b -> Frac.sub a (Frac.mul factor b)) row1 row2

let eliminate_column matrix pivot_row col =
  let pivot_row_data = List.nth matrix pivot_row in
  let pivot_val = List.nth pivot_row_data col in
  (* Normalize the pivot row so pivot = 1 *)
  let pivot_row_normalized = List.map (fun v -> Frac.div v pivot_val) pivot_row_data in
  List.mapi
    (fun idx row ->
      if idx = pivot_row then pivot_row_normalized
      else
        let val_at_col = List.nth row col in
        if Frac.is_zero val_at_col then row else sub_rows row pivot_row_normalized val_at_col)
    matrix

let swap_rows matrix i j =
  if i = j then matrix
  else
    List.mapi (fun idx row -> if idx = i then List.nth matrix j else if idx = j then List.nth matrix i else row) matrix

let find_pivot matrix col start_row =
  let rec aux row = function
    | [] -> None
    | r :: rest -> if row >= start_row && not (Frac.is_zero (List.nth r col)) then Some row else aux (row + 1) rest
  in
  aux 0 matrix

let forward_elim matrix =
  let num_rows = List.length matrix in
  let num_cols = List.length (List.hd matrix) - 1 in
  let rec aux matrix row col pivot_cols =
    if row >= num_rows || col >= num_cols then (matrix, List.rev pivot_cols)
    else
      match find_pivot matrix col row with
      | None -> aux matrix row (col + 1) pivot_cols
      | Some pivot_row ->
          let matrix = swap_rows matrix row pivot_row in
          let matrix = eliminate_column matrix row col in
          aux matrix (row + 1) (col + 1) (col :: pivot_cols)
  in
  aux matrix 0 0 []

let read_expressions matrix pivot_cols =
  let num_cols = List.length (List.hd matrix) - 1 in
  let free_cols = List.filter (fun c -> not (List.mem c pivot_cols)) (List.init num_cols Fun.id) in
  let expressions =
    List.mapi
      (fun row_idx pivot_col ->
        let matrix_row = List.nth matrix row_idx in
        let const = List.nth matrix_row num_cols in
        let coefs =
          List.filter_map
            (fun free_col ->
              let v = List.nth matrix_row free_col in
              if Frac.is_zero v then None else Some (Frac.sub Frac.zero v, free_col))
            free_cols
        in
        (pivot_col, (const, coefs)))
      pivot_cols
  in
  (expressions, free_cols)

let evaluate_expr (const, coefs) assignments =
  List.fold_left
    (fun acc (coef, free_col) ->
      let free_val = List.assoc free_col assignments in
      Frac.add acc (Frac.mul coef (Frac.of_int free_val)))
    const coefs

let find_min_sum buttons targets expressions free_cols =
  let num_free = List.length free_cols in
  if num_free = 0 then
    (* No free variables - just sum the constants if all are non-negative integers *)
    let basic_vals = List.map (fun (_, (const, _)) -> const) expressions in
    if List.for_all (fun v -> Frac.is_int v && Frac.(v >= zero)) basic_vals then
      Some (List.fold_left (fun acc v -> acc + Frac.to_int v) 0 basic_vals)
    else None
  else
    (* Compute upper bounds: button can't exceed smallest target it affects *)
    let max_target = List.fold_left max 1 targets in
    let compute_bound free_col =
      let btn = List.nth buttons free_col in
      List.fold_left (fun bound counter_idx -> min bound (List.nth targets counter_idx + 1)) (max_target + 1) btn
    in
    let bounds = List.map (fun free_col -> (free_col, compute_bound free_col)) free_cols in
    (* Search all combinations of free variable assignments *)
    let rec search assignments best =
      if List.length assignments = num_free then
        (* All free vars assigned - evaluate basic vars and check validity *)
        let basic_vals = List.map (fun (_, expr) -> evaluate_expr expr assignments) expressions in
        if List.for_all (fun v -> Frac.is_int v && Frac.(v >= zero)) basic_vals then
          let free_sum = List.fold_left (fun acc (_, v) -> acc + v) 0 assignments in
          let basic_sum = List.fold_left (fun acc v -> acc + Frac.to_int v) 0 basic_vals in
          let total = basic_sum + free_sum in
          match best with
          | None -> Some total
          | Some b -> Some (min b total)
        else best
      else
        (* Try each value 0..max_val for the next free variable *)
        let next_col = List.nth free_cols (List.length assignments) in
        let max_val = List.assoc next_col bounds in
        let rec try_val free_val best =
          if free_val > max_val then best
          else
            let new_assignments = (next_col, free_val) :: assignments in
            try_val (free_val + 1) (search new_assignments best)
        in
        try_val 0 best
    in
    search [] None

let min_increments line =
  let increments = parse_increments line in
  let joltage = parse_joltage line in
  let matrix = build_matrix increments joltage in
  let rref_matrix, pivot_cols = forward_elim matrix in
  let expressions, free_cols = read_expressions rref_matrix pivot_cols in
  find_min_sum increments joltage expressions free_cols

let () =
  let lines = read_lines () in
  let p1 = List.fold_left (fun acc line -> acc + min_presses (parse_lights line) (parse_toggles line)) 0 lines in
  Printf.printf "Part 1: %d\n" p1;
  let p2 =
    List.fold_left
      (fun acc line ->
        match min_increments line with
        | Some v -> acc + v
        | None -> failwith ("no solution found for: " ^ line))
      0 lines
  in
  Printf.printf "Part 2: %d\n" p2
