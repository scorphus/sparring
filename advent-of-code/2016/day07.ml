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

let take_abas s =
  let rec aux i acc =
    if i + 2 >= String.length s then acc
    else if s.[i] <> s.[i + 1] && s.[i] = s.[i + 2] then aux (i + 1) (String.sub s i 3 :: acc)
    else aux (i + 1) acc
  in
  aux 0 []

let aba_to_bab aba = String.init 3 (fun i -> if i = 1 then aba.[0] else aba.[1])

let contains_substring s sub =
  let rec aux i =
    i + String.length sub <= String.length s && (String.sub s i (String.length sub) = sub || aux (i + 1))
  in
  aux 0

let supports_ssl ip =
  let supernets, hypernets = List.mapi (fun i p -> (i, p)) ip |> List.partition (fun (i, _) -> i mod 2 = 0) in
  let abas = List.concat_map (fun (_, s) -> take_abas s) supernets in
  List.exists
    (fun aba ->
      let bab = aba_to_bab aba in
      List.exists (fun (_, h) -> contains_substring h bab) hypernets)
    abas

let () =
  let ips = read_ips () in
  Printf.printf "Part 1: %d\n" (List.filter supports_tls ips |> List.length);
  Printf.printf "Part 2: %d\n" (List.filter supports_ssl ips |> List.length)
