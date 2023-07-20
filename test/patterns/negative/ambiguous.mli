val f : int -> int
(*@ y = f x
    ensures match x with
    | _ | _ when x = 1 -> true
    | _ -> false *)
(* {gospel_expected|
   [125] File "ambiguous.mli", line 4, characters 6-11:
         4 |     | _ | _ when x = 1 -> true
                   ^^^^^
         Error: Ambiguous or-pattern under guard.
   |gospel_expected} *)
