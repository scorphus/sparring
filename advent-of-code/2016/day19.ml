let highest_power_of_2 n =
  let rec aux p = if p * 2 <= n then aux (p * 2) else p in
  aux 1

let josephus n =
  let p = highest_power_of_2 n in
  (2 * (n - p)) + 1

let () =
  let total_elves = match Sys.argv with [| _; n |] -> int_of_string n | _ -> failwith "Usage: day19 <total_elves>" in
  Printf.printf "Part 1: %d\n" (josephus total_elves)
