(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to constructor_args.mli.output
   (run %{checker} %{dep:constructor_args.mli}))))

(rule
 (alias runtest)
 (action
  (diff constructor_args.mli constructor_args.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:constructor_args.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to constructor_arity1.mli.output
   (run %{checker} %{dep:constructor_arity1.mli}))))

(rule
 (alias runtest)
 (action
  (diff constructor_arity1.mli constructor_arity1.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:constructor_arity1.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to constructor_arity2.mli.output
   (run %{checker} %{dep:constructor_arity2.mli}))))

(rule
 (alias runtest)
 (action
  (diff constructor_arity2.mli constructor_arity2.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:constructor_arity2.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to constructor_arity3.mli.output
   (run %{checker} %{dep:constructor_arity3.mli}))))

(rule
 (alias runtest)
 (action
  (diff constructor_arity3.mli constructor_arity3.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:constructor_arity3.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to constructor_arity4.mli.output
   (run %{checker} %{dep:constructor_arity4.mli}))))

(rule
 (alias runtest)
 (action
  (diff constructor_arity4.mli constructor_arity4.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:constructor_arity4.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to empty_match.mli.output
   (run %{checker} %{dep:empty_match.mli}))))

(rule
 (alias runtest)
 (action
  (diff empty_match.mli empty_match.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:empty_match.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to field_application.mli.output
   (run %{checker} %{dep:field_application.mli}))))

(rule
 (alias runtest)
 (action
  (diff field_application.mli field_application.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:field_application.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to invalid_modifies.mli.output
   (run %{checker} %{dep:invalid_modifies.mli}))))

(rule
 (alias runtest)
 (action
  (diff invalid_modifies.mli invalid_modifies.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:invalid_modifies.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to invariant5.mli.output
   (run %{checker} %{dep:invariant5.mli}))))

(rule
 (alias runtest)
 (action
  (diff invariant5.mli invariant5.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:invariant5.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to pattern_binding.mli.output
   (run %{checker} %{dep:pattern_binding.mli}))))

(rule
 (alias runtest)
 (action
  (diff pattern_binding.mli pattern_binding.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:pattern_binding.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to record_pattern1.mli.output
   (run %{checker} %{dep:record_pattern1.mli}))))

(rule
 (alias runtest)
 (action
  (diff record_pattern1.mli record_pattern1.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:record_pattern1.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to record_pattern2.mli.output
   (run %{checker} %{dep:record_pattern2.mli}))))

(rule
 (alias runtest)
 (action
  (diff record_pattern2.mli record_pattern2.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:record_pattern2.mli}))))

(rule
 (deps
  %{bin:gospel}
  (:checker %{project_root}/test/utils/testchecker.exe))
 (action
  (with-outputs-to record_pattern3.mli.output
   (run %{checker} %{dep:record_pattern3.mli}))))

(rule
 (alias runtest)
 (action
  (diff record_pattern3.mli record_pattern3.mli.output)))

(rule
 (alias test-cmis)
 (action
  (chdir %{project_root}
   ; Syntax sanity check
   (run ocamlc -c %{dep:record_pattern3.mli}))))

