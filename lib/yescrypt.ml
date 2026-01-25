(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: yescrypt.ml
*)

open Ctypes

module F = Yescrypt_bindings.Functions(Yescrypt_generated)
module Internal = Yescrypt_internal

exception Crypto_scrypt_error of string

(* ----------- *)
(*   Scrypt    *)
(* ----------- *)

let crypto_scrypt_bytes
    ~(passwd : string)
    ~(salt : string)
    ~(n : int)
    ~(r : int)
    ~(p : int)
    ~(buf_len : int)
  : bytes =
  let passwd_arr = Internal.string_to_uint8_carray passwd in
  let salt_arr = Internal.string_to_uint8_carray salt in
  let buf_arr = CArray.make uint8_t buf_len in

  let result = F.crypto_scrypt
    (CArray.start passwd_arr)
    (Unsigned.Size_t.of_int (String.length passwd))
    (CArray.start salt_arr)
    (Unsigned.Size_t.of_int (String.length salt))
    (Unsigned.UInt64.of_int n)
    (Unsigned.UInt32.of_int r)
    (Unsigned.UInt32.of_int p)
    (CArray.start buf_arr)
    (Unsigned.Size_t.of_int buf_len)
  in
  if result <> 0 then
    raise (Crypto_scrypt_error "crypto_scrypt failed")
  else
    Internal.uint8_carray_to_bytes buf_arr

let crypto_scrypt
    ~(passwd : string)
    ~(salt : string)
    ~(n : int)
    ~(r : int)
    ~(p : int)
    ~(buf_len : int)
  : string =
  let result = crypto_scrypt_bytes ~passwd ~salt ~n ~r ~p ~buf_len in
  let hex = Buffer.create (buf_len * 2) in
  Bytes.iter (fun c -> Buffer.add_string hex (Printf.sprintf "%02x" (Char.code c))) result;
  Buffer.contents hex


(* ------------------------------- *)
(*   Yescrypt - Enhanced scrypt    *)
(* ------------------------------- *)

module T = Yescrypt_bindings.Types

exception Yescrypt_error of string

(** Generate a yescrypt setting/params string *)
let yescrypt_encode_params
    ~(n : int)
    ~(r : int)
    ~(p : int)
    ~(salt : string)
    : string =
  let params = make T.yescrypt_params_t in
  setf params T.flags (Unsigned.UInt32.of_int Yescrypt_flags.defaults);
  setf params T.n (Unsigned.UInt64.of_int n);
  setf params T.r (Unsigned.UInt32.of_int r);
  setf params T.p (Unsigned.UInt32.of_int p);
  setf params T.t (Unsigned.UInt32.of_int 0);
  setf params T.g (Unsigned.UInt32.of_int 0);
  setf params T.nrom (Unsigned.UInt64.of_int 0);

  let salt_arr = Internal.string_to_uint8_carray salt in
  let result_ptr = F.yescrypt_encode_params
    (addr params)
    (CArray.start salt_arr)
    (Unsigned.Size_t.of_int (String.length salt))
  in
  if is_null result_ptr then
    raise (Yescrypt_error "yescrypt_encode_params failed")
  else
    let rec read_string ptr acc =
      let c = !@ ptr in
      if Unsigned.UInt8.to_int c = 0 then
        acc
      else
        read_string (ptr +@ 1) (acc ^ String.make 1 (Char.chr (Unsigned.UInt8.to_int c)))
    in
    read_string result_ptr ""

let yescrypt_raw ~(passwd : string) ~(setting : string) : string =
  let passwd_arr = Internal.string_to_uint8_carray passwd in
  let setting_arr = Internal.string_to_uint8_carray (setting ^ "\x00") in

  let result_ptr = F.yescrypt
    (CArray.start passwd_arr)
    (CArray.start setting_arr)
  in
  if is_null result_ptr then
    raise (Yescrypt_error "yescrypt failed")
  else
    let rec read_string ptr acc =
      let c = !@ ptr in
      if Unsigned.UInt8.to_int c = 0 then
        acc
      else
        read_string (ptr +@ 1) (acc ^ String.make 1 (Char.chr (Unsigned.UInt8.to_int c)))
    in
    read_string result_ptr ""

let yescrypt
    ~(passwd : string)
    ~(salt : string)
    ~(n : int)
    ~(r : int)
    ~(p : int)
    : string =
  let setting = yescrypt_encode_params ~n ~r ~p ~salt in
  yescrypt_raw ~passwd ~setting

