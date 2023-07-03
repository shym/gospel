val scalar_product : int list -> int -> int list

(*@ r = scalar_product v s
    ensures List.map integer_of_int r = List.map ((fun x y -> x * integer_of_int y) (integer_of_int s)) v *)
(* {gospel_expected|
   [125] File "partial_application.mli", line 4, characters 21-35:
         4 |     ensures List.map integer_of_int r = List.map ((fun x y -> x * integer_of_int y) (integer_of_int s)) v *)
                                  ^^^^^^^^^^^^^^
         Error: This term has type `integer' but a term was expected of type
                `int -> integer'.
   |gospel_expected} *)
