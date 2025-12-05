let bunny_hash door_id n = door_id ^ string_of_int n |> Digest.string |> Digest.to_hex

let find_password door_id =
  let rec aux index acc =
    if List.length acc = 8 then acc |> List.rev |> List.to_seq |> String.of_seq
    else
      let hash = bunny_hash door_id index in
      if String.starts_with ~prefix:"00000" hash then aux (index + 1) (hash.[5] :: acc) else aux (index + 1) acc
  in
  aux 0 []

let () =
  let door_id = match Sys.argv with [| _; door_id |] -> door_id | _ -> failwith "Usage: day05 <door_id>" in
  Printf.printf "Part 1: %s\n" (find_password door_id)
