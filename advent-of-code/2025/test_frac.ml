#use "frac.ml"

let () =
  let open Frac in
  (* make *)
  assert (make 2 4 = (1, 2));
  assert (make (-3) 6 = (-1, 2));
  assert (make 3 (-6) = (-1, 2));
  assert (make 5 5 = (1, 1));

  (* of_int *)
  assert (of_int 3 = (3, 1));
  assert (of_int (-7) = (-7, 1));

  (* add *)
  assert (add (of_int 1) (of_int 2) = of_int 3);
  assert (add (1, 2) (1, 2) = (1, 1));
  assert (add (1, 2) (2, 3) = (7, 6));

  (* sub *)
  assert (sub (of_int 5) (of_int 3) = of_int 2);
  assert (sub (1, 2) (1, 2) = (0, 1));
  assert (sub (1, 2) (2, 3) = (-1, 6));

  (* mul *)
  assert (mul (1, 2) (2, 3) = (1, 3));
  assert (mul (of_int 2) (of_int 3) = of_int 6);

  (* div *)
  assert (div (1, 2) (2, 3) = (3, 4));
  assert (div (of_int 1) (of_int 2) = (1, 2));

  (* is_zero *)
  assert (is_zero zero);
  assert (not (is_zero (of_int 1)));

  (* is_int *)
  assert (is_int (of_int 42));
  assert (not (is_int (1, 2)));

  (* to_int *)
  assert (to_int (of_int 7) == 7);

  (* compare *)
  assert ((1, 2) < (2, 3));
  assert ((2, 3) > (1, 2));
  assert ((1, 2) <= (1, 2));
  assert ((1, 2) >= (1, 2));

  print_endline "All Frac tests passed!"
