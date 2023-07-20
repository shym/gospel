(**************************************************************************)
(*                                                                        *)
(*  GOSPEL -- A Specification Language for OCaml                          *)
(*                                                                        *)
(*  Copyright (c) 2018- The VOCaL Project                                 *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

type 'a t = { x : int; y : 'a }

(*@ function f (x: 'a t): int =
    match x with
    | { x = x; y = x } -> x *)

(* {gospel_expected|
   [125] File "t36.mli", line 11, characters 8-9:
         11 | type 'a t = { x : int; y : 'a }
                      ^
         Error: The type `t' expects 1 argument(s) but was given 0 argument(s) here.
   |gospel_expected} *)
