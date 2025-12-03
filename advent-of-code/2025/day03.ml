let parse_bank line = String.fold_left (fun acc c -> (int_of_char c - int_of_char '0') :: acc) [] line |> List.rev

let read_battery_banks () =
  let rec aux acc =
    try
      let line = read_line () in
      let bank = parse_bank line in
      aux (bank :: acc)
    with
    | End_of_file -> List.rev acc
  in
  aux []

let find_largest_joltage bank =
  let rec aux acc = function
    | []
    | [ _ ] ->
        acc
    | b :: bank -> aux (max acc ((b * 10) + List.fold_left max 0 bank)) bank
  in
  aux 0 bank

let () =
  let banks = read_battery_banks () in
  let largest_joltages = List.map find_largest_joltage banks in
  let total_joltage = List.fold_left (fun acc x -> acc + x) 0 largest_joltages in
  Printf.printf "Part 1: %d\n" total_joltage
