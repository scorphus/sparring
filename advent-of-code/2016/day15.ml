let parse_disc line =
  try
    Scanf.sscanf line "Disc #%d has %d positions; at time=0, it is at position %d." (fun id positions start ->
        (id, positions, start))
  with Scanf.Scan_failure _ -> failwith ("Failed to parse line: " ^ line)

let rec read_discs discs =
  try
    let disc = read_line () |> parse_disc in
    read_discs (disc :: discs)
  with End_of_file -> discs

let will_disc_open time (id, positions, start) = (id + start + time) mod positions = 0

let find_time_for_another_capsule discs =
  let rec aux time = if List.for_all (will_disc_open time) discs then time else aux (time + 1) in
  aux 0

let () =
  let time = read_discs [] |> find_time_for_another_capsule in
  Printf.printf "Part 1: %d\n" time
