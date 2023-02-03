# Extract OCaml code blocks in a markdown documentation into a .mli
# file

# If a code block is started with
#   ```ocaml invalidSyntax
# or
#   ```ocaml implementationSyntax
# it will be skipped, so that the documentation can contain invalid
# syntax (with `...` for instance) or contain .ml (implementation)
# code

/^ *```ocaml/,/^ *```$/ {
  if($0 ~ "^ *```ocaml.*invalidSyntax" || $0 ~ "^ *```ocaml.*implementationSyntax" ) {
    skip = 1
  } else if($0 ~ "^ *```ocaml") {
    skip = 0
    printf "# %d \"%s\"\n", FNR+1, FILENAME
  } else if($0 ~ "^ *```$") {
    # Print an end of block, so that gospel specifications in one code
    # block are not attached to a previous value by mistake
    print "(* --- *)"
    print ""
  } else if(!skip) {
    print
  }
}
