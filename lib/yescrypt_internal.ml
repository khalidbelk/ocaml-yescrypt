(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: yescrypt_internal.ml - Internal utilities (not exposed to users)
*)

open Ctypes

(** Convert a string to a uint8 CArray (keeps data alive) *)
let string_to_uint8_carray (s : string) : Unsigned.uint8 CArray.t =
  let len = String.length s in
  let arr = CArray.make uint8_t len in
  for i = 0 to len - 1 do
    CArray.set arr i (Unsigned.UInt8.of_int (Char.code s.[i]))
  done;
  arr

(** Read back from a uint8 CArray into bytes *)
let uint8_carray_to_bytes (arr : Unsigned.uint8 CArray.t) : bytes =
  let len = CArray.length arr in
  let b = Bytes.create len in
  for i = 0 to len - 1 do
    Bytes.set b i (Char.chr (Unsigned.UInt8.to_int (CArray.get arr i)))
  done;
  b
