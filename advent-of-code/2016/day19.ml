let highest_power_of_2 n =
  let rec aux p = if p * 2 <= n then aux (p * 2) else p in
  aux 1

let highest_power_of_3 n =
  let rec aux p = if p * 3 <= n then aux (p * 3) else p in
  aux 1

let josephus_next n =
  let p = highest_power_of_2 n in
  (2 * (n - p)) + 1

let josephus_across n =
  let p = highest_power_of_3 n in
  if n = p then n else if n <= 2 * p then n - p else (2 * n) - (3 * p)

let () =
  let total_elves = match Sys.argv with [| _; n |] -> int_of_string n | _ -> failwith "Usage: day19 <total_elves>" in
  Printf.printf "Part 1: %d\n" (josephus_next total_elves);
  Printf.printf "Part 2: %d\n" (josephus_across total_elves)
