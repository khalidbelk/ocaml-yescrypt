(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: yescrypt.ml
*)

open Ctypes

module F = Yescrypt_bindings.Functions(Yescrypt_generated)

let crypto_test passwd passwdlen salt saltlen  n r p buf buflen =
  F.crypto_scrypt
    (CArray.start passwd)
    (Unsigned.Size_t.of_int passwdlen)
    (CArray.start salt)
    (Unsigned.Size_t.of_int saltlen)
    (Unsigned.UInt64.of_int n)
    (Unsigned.UInt32.of_int r)
    (Unsigned.UInt32.of_int p)
    (CArray.start buf)
    (Unsigned.Size_t.of_int buflen)