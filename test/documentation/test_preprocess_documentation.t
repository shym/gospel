Testing interaction between `gospel pps` and Ocaml compiler. The issue is that
`gospel pps` detached documentation comments. In order to check whether this is
the case or not, we need to make the output of the gospel preprocessor go
through OCaml compiler and then ask for a source that could have generated it
(with the `-dsource` option).

First, we create a small test artifact with the problematic interleaving of
documentation comment and gospel specification:

  $ cat > foo.mli << EOF
  > val f : int -> int
  > (** documentation *)
  > (*@ y = f x *)
  > EOF

Now, we look at how the OCaml compiler understand the output of the gospel
preprocessor. We also enable the compiler warning about unexpected docstring:

  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  val f : int -> int[@@ocaml.doc {| documentation |}][@@gospel {| y = f x |}]

Another problematic interleaving is the documentation of ghost declaration with
and without specifications:

  $ cat > foo.mli << EOF
  > (*@ type casper *)
  > (** a ghost type *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "foo.mli", line 2, characters 0-19:
  2 | (** a ghost type *)
      ^^^^^^^^^^^^^^^^^^^
  Warning 50 [unexpected-docstring]: unattached documentation comment (ignored)
  [@@@gospel {| type casper |}]

  $ cat > foo.mli << EOF
  > (*@ type casper *) (** a ghost type *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "foo.mli", line 1, characters 19-38:
  1 |                  ] (** a ghost type *)
                         ^^^^^^^^^^^^^^^^^^^
  Warning 50 [unexpected-docstring]: unattached documentation comment (ignored)
  [@@@gospel {| type casper |}]

  $ cat > foo.mli << EOF
  > (*@ type casper *)
  > (*@ model transparent : bool *)
  > (** a ghost type *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "foo.mli", line 3, characters 0-19:
  3 | (** a ghost type *)
      ^^^^^^^^^^^^^^^^^^^
  Warning 50 [unexpected-docstring]: unattached documentation comment (ignored)
  [@@@gospel {| type casper |}[@@gospel {| model transparent : bool |}]]

  $ cat > foo.mli << EOF
  > (*@ type casper *)
  > (** a ghost type *)
  > (*@ model transparent : bool *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "foo.mli", line 3, characters 0-3:
  3 | [@@gospel
      ^^^
  Error: Syntax error
  [2]

  $ cat > foo.mli << EOF
  > (** a ghost type *)
  > (*@ type casper *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "/tmp/build_6eba16_dune/ocamlppa443c3", line 1, characters 0-19:
  Warning 50 [unexpected-docstring]: unattached documentation comment (ignored)
  [@@@gospel {| type casper |}]

  $ cat > foo.mli << EOF
  > (** a ghost type *)
  > (*@ type casper *)
  > (*@ model transparent : bool *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "/tmp/build_6eba16_dune/ocamlppa3a62b", line 1, characters 0-19:
  Warning 50 [unexpected-docstring]: unattached documentation comment (ignored)
  [@@@gospel {| type casper |}[@@gospel {| model transparent : bool |}]]

Interleaving ghost-documentation-specification is not accepted if there is more
than one newline between at least two of the consecutive elements:

  $ cat > foo.mli << EOF
  > (*@ type casper *)
  > 
  > (** a ghost type *)
  > (*@ model transparent : bool *)
  > EOF
  $ ocamlc -pp "gospel pps" -dsource -w +50 foo.mli
  File "foo.mli", line 4, characters 0-3:
  4 | [@@gospel
      ^^^
  Error: Syntax error
  [2]


We now test the locations.

In order to test the locations, we will make an error in the gospel
specifications after an multi-line informal documentation block:

  $ cat > foo.mli << EOF
  > val f : int -> int
  > (** multi
  >     (* line *)
  >     documentation *)
  > (*@ y = f x z *)
  > EOF

Gospel preprocessing should indicate the correct location with the `#` syntax:

  $ gospel pps foo.mli
  val f : int -> int
  [@@ocaml.doc
  # 2 "foo.mli"
   {| multi
      (* line *)
      documentation |}
  # 4 "foo.mli"
                     ]
  [@@gospel
  # 5 "foo.mli"
   {| y = f x z |}
  # 5 "foo.mli"
                 ]
  



Gospel typechecking should spot an error and locate it at the fifth line of the file:

  $ gospel check foo.mli
  File "foo.mli", line 5, characters 8-9:
  5 | (*@ y = f x z *)
              ^
  Error: Type checking error: too many parameters.
  [125]


Another corner case is the empty documentation attibute:

  $ cat > foo.mli << EOF
  > val f : int -> int
  > (**)
  > (*@ y = f x z *)
  > EOF
  $ gospel pps foo.mli
  val f : int -> int
  [@@ocaml.doc
  # 2 "foo.mli"
     ]
  [@@gospel
  # 3 "foo.mli"
   {| y = f x z |}
  # 3 "foo.mli"
                 ]
  



And some other corner cases with different spacing:

  $ cat > foo.mli << EOF
  > val f : int -> int(*@ y = f x z *)
  > EOF
  $ gospel pps foo.mli
  val f : int -> int[@@gospel
  # 1 "foo.mli"
                     {| y = f x z |}
  # 1 "foo.mli"
                                   ]
  



  $ cat > foo.mli << EOF
  > val f : int -> int(** documentation *)
  > (*@ y = f x *)
  > EOF
  $ gospel pps foo.mli
  val f : int -> int[@@ocaml.doc
  # 1 "foo.mli"
                     {| documentation |}
  # 1 "foo.mli"
                                       ]
  [@@gospel
  # 2 "foo.mli"
   {| y = f x |}
  # 2 "foo.mli"
               ]
  



  $ cat > foo.mli << EOF
  > val f : int -> int(** documentation *)(*@ y = f x *)
  > EOF
  $ gospel pps foo.mli
  val f : int -> int[@@ocaml.doc
  # 1 "foo.mli"
                     {| documentation |}
  # 1 "foo.mli"
                                       ][@@gospel
  # 1 "foo.mli"
                                         {| y = f x |}
  # 1 "foo.mli"
                                                     ]
  



Finally, just a little clean up after ourselves.

  $ rm foo.mli
