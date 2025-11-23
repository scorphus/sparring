let parse_instr line =
  try
    Scanf.sscanf line "bot %d gives low to %s %d and high to %s %d" (fun giver kind_lo rec_lo kind_hi rec_hi ->
        `Giving (giver, kind_lo, rec_lo, kind_hi, rec_hi))
  with Scanf.Scan_failure _ -> Scanf.sscanf line "value %d goes to bot %d" (fun value bot -> `Going (value, bot))

module IntMap = Map.Make (Int)

(* Helper to append to list at a key *)
let append_to_key map key value =
  match IntMap.find_opt key map with
  | None -> IntMap.add key [ value ] map
  | Some existing -> IntMap.add key (value :: existing) map

let read_instructions () =
  let rec aux bots givings =
    try
      let line = read_line () in
      match parse_instr line with
      | `Giving (giver, kind_lo, rec_lo, kind_hi, rec_hi) ->
          let givings = IntMap.add giver (kind_lo, rec_lo, kind_hi, rec_hi) givings in
          aux bots givings
      | `Going (value, bot) ->
          let bots = append_to_key bots bot value in
          aux bots givings
    with End_of_file -> (bots, givings)
  in
  aux IntMap.empty IntMap.empty

let rec process bots givings hi lo the_bot bins =
  let bot, val_lo, val_hi =
    IntMap.fold
      (fun bot values acc ->
        match List.length values with
        | 2 -> (bot, List.fold_left min max_int values, List.fold_left max min_int values)
        | _ -> acc)
      bots (-1, -1, -1)
  in
  if bot = -1 then (the_bot, bins)
  else
    let the_bot = if (val_lo, val_hi) = (lo, hi) then bot else the_bot in
    let bots = IntMap.add bot [] bots in
    let kind_lo, rec_lo, kind_hi, rec_hi = IntMap.find bot givings in
    let bots, bins =
      if kind_lo = "bot" then (append_to_key bots rec_lo val_lo, bins) else (bots, IntMap.add rec_lo val_lo bins)
    in
    let bots, bins =
      if kind_hi = "bot" then (append_to_key bots rec_hi val_hi, bins) else (bots, IntMap.add rec_hi val_hi bins)
    in
    process bots givings hi lo the_bot bins

let () =
  let hi, lo =
    match Sys.argv with
    | [| _; hi; lo |] ->
        let hi = int_of_string hi in
        let lo = int_of_string lo in
        (hi, lo)
    | _ -> failwith "Usage: day10 <hi> <lo>"
  in
  let bots, givings = read_instructions () in
  let the_bot, bins = process bots givings hi lo (-1) IntMap.empty in
  Printf.printf "Part 1: %d\n" the_bot;
  let part2 = List.fold_left (fun acc output -> IntMap.find output bins * acc) 1 [ 0; 1; 2 ] in
  Printf.printf "Part 2: %d\n" part2
