module Frac = struct
  type t = int * int

  let rec gcd a b = if b = 0 then a else gcd b (a mod b)

  let make n d =
    if d = 0 then failwith "division by zero"
    else
      let g = gcd (abs n) (abs d) in
      let sign = if d < 0 then -1 else 1 in
      (sign * n / g, sign * d / g)

  let of_int n = (n, 1)
  let zero = (0, 1)
  let num (n, _) = n
  let den (_, d) = d

  let add (n1, d1) (n2, d2) = make ((n1 * d2) + (n2 * d1)) (d1 * d2)
  let sub (n1, d1) (n2, d2) = make ((n1 * d2) - (n2 * d1)) (d1 * d2)
  let mul (n1, d1) (n2, d2) = make (n1 * n2) (d1 * d2)
  let div (n1, d1) (n2, d2) = make (n1 * d2) (d1 * n2)

  let is_zero (n, _) = n = 0
  let is_int (_, d) = d = 1
  let to_int (n, d) = if d = 1 then n else failwith "not an integer"
  let to_string (n, d) = if d = 1 then string_of_int n else Printf.sprintf "%d/%d" n d

  let compare (n1, d1) (n2, d2) = compare (n1 * d2) (n2 * d1)
  let ( = ) a b = compare a b = 0
  let ( < ) a b = compare a b < 0
  let ( > ) a b = compare a b > 0
  let ( >= ) a b = compare a b >= 0
  let ( <= ) a b = compare a b <= 0
end
