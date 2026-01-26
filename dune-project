(lang dune 3.16)
(name ocaml-yescrypt)
(version 0.1.1)

(using ctypes 0.3)

(generate_opam_files true)

(source
 (github khalidbelk/ocaml-yescrypt))

(authors "Khalid B.")

(maintainers "Khalid B.")

(license "Apache-2.0")

(documentation https://khalidbelk.github.io/ocaml-yescrypt/index.html)

(package
 (name ocaml-yescrypt)
 (synopsis "OCaml bindings for the Yescrypt KDF")
 (description "OCaml bindings for the Yescrypt password hashing / key derivation function.")
 (depends
  (ocaml (>= "5.0"))
  (dune (>= "3.16"))
  (ctypes (>= "0.20"))
  ctypes-foreign
  (ounit2 :with-test)
 )
 (tags
  (cryptography password-hashing kdf yescrypt scrypt ocaml bindings)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
