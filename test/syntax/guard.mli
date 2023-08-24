val f : int -> int
(*@ y = f x
      requires 0 = match x with _ when match 1 with _ -> true -> 1 | _ -> 2
*)

(* missing parentheses around nested match, as the above expression is parsed
   as:
     match x with
       _ when (match 1 with _ -> (true -> 1)
                          | _ -> 2)
*)

(* {gospel_expected|
   [125] File "guard2.mli", line 3, characters 76-76:
         Error: Syntax error.
   |gospel_expected} *)
