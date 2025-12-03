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

let rec find_max_in_first n best best_tail = function
  | [] -> (best, best_tail)
  | _ when n = 0 -> (best, best_tail)
  | b :: bank when b > best -> find_max_in_first (n - 1) b bank bank
  | _ :: bank -> find_max_in_first (n - 1) best best_tail bank

let find_largest_joltage_n bank n =
  let rec aux remaining acc = function
    | [] -> acc
    | _ when remaining = 0 -> acc
    | bank ->
        let skip = List.length bank - remaining + 1 in
        let best, rest = find_max_in_first skip 0 bank bank in
        aux (remaining - 1) ((acc * 10) + best) rest
  in
  aux n 0 bank

let () =
  let banks = read_battery_banks () in
  let p1 = List.fold_left (fun acc b -> acc + find_largest_joltage b) 0 banks in
  let p2 = List.fold_left (fun acc b -> acc + find_largest_joltage_n b 12) 0 banks in
  Printf.printf "Part 1: %d\n" p1;
  Printf.printf "Part 2: %d\n" p2
