let reverse_string s =
  let len = String.length s in
  let buf = Buffer.create len in
  for i = len - 1 downto 0 do
    Buffer.add_char buf s.[i]
  done;
  Buffer.contents buf

let rec dragon_curve data =
  let b = String.map (function '0' -> '1' | '1' -> '0' | c -> c) (reverse_string data) in
  data ^ "0" ^ b

let rec fill_data data desired_length =
  if String.length data >= desired_length then String.sub data 0 desired_length
  else fill_data (dragon_curve data) desired_length

let checksum a =
  let rec aux s =
    let len = String.length s in
    if len mod 2 = 1 then s else aux (String.init (len / 2) (fun i -> if s.[i * 2] = s.[(i * 2) + 1] then '1' else '0'))
  in
  aux a

let () =
  let initial_state =
    match Sys.argv with [| _; initial_state |] -> initial_state | _ -> failwith "Usage: day16 <initial_state>"
  in
  Printf.printf "Part 1: %s\n" (fill_data initial_state 272 |> checksum)
