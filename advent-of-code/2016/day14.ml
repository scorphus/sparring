let window = 1000
let md5_hash str = Digest.string str |> Digest.to_hex

let gen_hashes salt id =
  let key = salt ^ string_of_int id in
  md5_hash key

let find_nlet hash n =
  let rec aux i =
    if i + n > String.length hash then None
    else
      let first = hash.[i] in
      let rec all_same j = j >= n || (hash.[i + j] = first && all_same (j + 1)) in
      if all_same 1 then Some (String.sub hash i n) else aux (i + 1)
  in
  aux 0

let find_key tri_id tri_str quis =
  if tri_id = 0 then None
  else
    let rec aux = function
      | [] -> None
      | (qui_id, qui_str) :: tail when tri_id <> qui_id && tri_str = qui_str && qui_id - tri_id <= window -> Some tri_id
      | _ :: tail -> aux tail
    in
    aux quis

let decide id tri_id qui_id =
  match (tri_id, qui_id) with
  | _ when tri_id > 0 && id - tri_id > window && qui_id <= tri_id -> `DropBoth
  | _ when tri_id > 0 && id - tri_id > window -> `DropTri
  | _ when qui_id > 0 && qui_id <= tri_id -> `DropQui
  | _ -> `DropNone

let extract_head = function [] -> ((0, ""), []) | h :: t -> (h, t)

let gen_keys salt =
  let rec aux id tris quis () =
    let (tri_id, tri_str), tri_t = extract_head tris in
    let (qui_id, qui_str), qui_t = extract_head quis in
    match find_key tri_id tri_str quis with
    | Some key_id -> Seq.Cons (key_id, aux id tri_t quis)
    | None -> (
        match decide id tri_id qui_id with
        | `DropNone ->
            let hash = gen_hashes salt id in
            let tris = match find_nlet hash 3 with Some t -> tris @ [ (id, t) ] | None -> tris in
            let quis = match find_nlet hash 5 with Some q -> quis @ [ (id, String.sub q 0 3) ] | None -> quis in
            aux (id + 1) tris quis ()
        | `DropTri -> aux id tri_t quis ()
        | `DropQui -> aux id tris qui_t ()
        | `DropBoth -> aux id tri_t qui_t ())
  in
  aux 1 [] []

let () =
  let salt, n =
    match Sys.argv with [| _; salt; n |] -> (salt, int_of_string n) | _ -> failwith "Usage: day14 <salt> <n>"
  in
  let nth_key = gen_keys salt |> Seq.drop (n - 1) |> Seq.take 1 |> List.of_seq |> List.hd in
  Printf.printf "Part 1: %d\n" nth_key
