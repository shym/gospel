val x : int -> int
val invalid_modifies : unit -> unit
(*@ invalid_modifies ()
    modifies x
*)

(* {gospel_expected|
   [125] File "constants1.mli", line 5, characters 13-14:
         5 |     modifies x
                          ^
         Error: Symbol x not found.
   |gospel_expected} *)
