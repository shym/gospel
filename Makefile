all:
	dune build

install:
	dune build @install && dune install

test:
	dune runtest

format:
	dune build @fmt --auto-promote


# To check that the markdown documentation is kept valid

GOSPEL_CMD := dune exec --display=quiet -- bin/cli.exe
DOCUMENTS := README.mli
# DOCUMENTS += docs/docs/getting-started/first-spec.mli # duplicate definitions in OCaml blocks
DOCUMENTS += docs/docs/language/constants-specifications.mli
DOCUMENTS += docs/docs/language/function-contracts.mli
DOCUMENTS += docs/docs/language/locations.mli
DOCUMENTS += docs/docs/language/logical.mli
DOCUMENTS += docs/docs/language/type-specifications.mli
# DOCUMENTS += docs/docs/walkthroughs/fibonacci.mli # `let` in OCaml block
DOCUMENTS += docs/docs/walkthroughs/mutable-queue.mli
DOCUMENTS += docs/docs/walkthroughs/union-find.mli
# DOCUMENTS += docs/src/pages/faq.mli # `...` in OCaml block
CHECKS := $(patsubst %,%.check,$(DOCUMENTS))

.PRECIOUS: $(DOCUMENTS)

%.mli: %.md
	awk '/^ *```ocaml/,/^ *```$$/ { if ($$0 !~ "^ *```") print }' < $< > $@

%.check: %
	$(GOSPEL_CMD) check $<

checks: $(CHECKS)

clean:
	dune clean
	rm $(DOCUMENTS) || true

.PHONY: all clean format test checks
