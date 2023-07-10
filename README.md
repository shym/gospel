<div align="center">
  <h1>Gospel</h1>
  <strong>A tool-agnostic formal specification language for OCaml.</strong>
</div>

<div align="center">
<br />

[![license](https://img.shields.io/github/license/ocaml-gospel/gospel.svg?style=flat-square)](LICENSE)

[![OCaml-CI Build Status](https://img.shields.io/endpoint?url=https%3A%2F%2Fci.ocamllabs.io%2Fbadge%2Focaml-gospel%2Fgospel%2Fmain&logo=ocaml&style=flat-square)](https://ci.ocamllabs.io/github/ocaml-gospel/gospel)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/ocaml-gospel/gospel?style=flat-square)](https://github.com/ocaml-gospel/gospel/releases/latest)
[![documentation](https://img.shields.io/badge/documentation-online-blue?style=flat-square)](https://ocaml-gospel.github.io/gospel)

</div>

## About

Gospel is a behavioural specification language for OCaml program. It provides
developers with a non-invasive and easy-to-use syntax to annotate their module
interfaces with formal contracts that describe type invariants, mutability,
function pre-conditions and post-conditions, effects, exceptions, and [much
more](https://ocaml-gospel.github.io/gospel/)!

<div align="center">
<img src="screenshot.png" title="Gospel specification">
</div>

We designed Gospel to provide a tool-agnostic frontend for bringing formal
methods into the OCaml ecosystem, meaning that we make no assumptions on the
future use of the specifications.

You can use Gospel specifications to complete and precise your documentation
comments with non-ambiguous annotations and use a type-checker to ensure they
always remain in sync. Other tools also rely on these annotations to provide
additional features such as automated deductive verification or runtime
assertion checking.

Please feel free to visit [the project
page](https://ocaml-gospel.github.io/gospel) if you wish to learn more about
Gospel!

## Getting Started

### Installation

Gospel is not yet available on Opam repositories. You can install it via pinning:

```shell
$ opam pin add gospel.dev git@github.com:ocaml-gospel/gospel
$ opam install gospel
```

This will install the `gospel` tool binary, as well as the developer library if you
wish to build your software on top of Gospel. You may check the installation with.

```shell
$ gospel --version
gospel version xxxxxx
```

### Usage

Gospel contracts live in OCaml interface files (`.mli`), as special comments
starting with the `@` symbol:

```ocaml
val max_array: int array -> int
(*@ m = max_array a
    requires Array.length a > 0
    ensures forall i. 0 <= i < Array.length a -> a.(i) <= m
    ensures exists i. 0 <= i < Array.length a /\ a.(i) = m *)
```

Gospel provides a type-checker that ensures that your specifications are
well-formed, well-typed, and remain in sync with the interface they annotate!

```shell
$ gospel check max_array.mli
OK
```

Gospel also provides a ppx rewriter to allow odoc to display the contents of
gospel specifications and declarations as documentation. This ppx rewriter
works under the assumption that the source preprocessor has been run first. The
dune stanza read as follow:

```dune
(library
 (name lib_name)
 (preprocess
 (pps gospel.ppx -- -pp "gospel pps")))
```

Be aware that it is the user's responsability to run the gospel type-checker when needed.

### Tools using Gospel

> You are using Gospel as a frontend? [Let us
> know!](https://github.com/ocaml-gospel/gospel/discussions/new?category=show-and-tell)

At the moment, three tools leverage Gospel specifications to provide more
guarantees to your programs:

- **[Cameleer](https://github.com/ocaml-gospel/cameleer).** A tool that extends
  Gospel to implementation files to provide semi-automated deductive
  verification of OCaml programs.
- **[Ortac](https://github.com/ocaml-gospel/ortac).** A runtime assertion
  checking tool based that generates verifying code for your test suites or
  programs monitors.
- **[Why3gospel](https://github.com/ocaml-gospel/why3gospel).** A Why3 plugin that
  lets you verify that a program proof refines the Gospel specifications before
  extracting it to OCaml.

## License

This project is licensed under the **MIT license**.

See the [LICENSE](LICENSE) file for more information.

## Authors

Gospel was initially developed by Cláudio Lourenço (LRI postdoctorate).

It is now maintained by Clément Pascutto, Mário Pereira, and Jean-Christophe
Filliâtre.

The full list of contributors is available
[here](https://github.com/ocaml-gospel/gospel/graphs/contributors).

## Acknowledgements

This project is part of a collaboration between the [LMF
laboratory](https://lmf.cnrs.fr/), [Tarides](https://tarides.com/), and [NOVA
LINCS](https://nova-lincs.di.fct.unl.pt/).

The development is supported by:

- The [VOCaL project](https://vocal.lri.fr). ANR grant No.
  [ANR-15-CE25-0008](https://anr.fr/Project-ANR-15-CE25-0008), 1/10/2015 -
  31/3/2021.
- The HORIZON 2020 Cameleer project (Marie Skłodowska-Curie grant agreement
  ID:897873) and NOVA LINCS (Ref. UIDB/04516/2020).
