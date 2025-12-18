#load "str.cma"

let parse_ip line = Str.split (Str.regexp "[][]") line

let read_ips () =
  let rec aux acc = try aux (parse_ip (read_line ()) :: acc) with End_of_file -> List.rev acc in
  aux []

let is_abba s =
  let rec aux i =
    i + 3 < String.length s && ((s.[i] <> s.[i + 1] && s.[i] = s.[i + 3] && s.[i + 1] = s.[i + 2]) || aux (i + 1))
  in
  aux 0

let supports_tls ip =
  let supernets, hypernets = List.mapi (fun i p -> (i, p)) ip |> List.partition (fun (i, _) -> i mod 2 = 0) in
  List.exists (fun (_, s) -> is_abba s) supernets && not (List.exists (fun (_, s) -> is_abba s) hypernets)

let () =
  let ips = read_ips () in
  Printf.printf "Part 1: %d\n" (List.filter supports_tls ips |> List.length)
