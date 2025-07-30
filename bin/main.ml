open Ctypes
open Yescrypt


let str_to_uint8_carray (s : string) : Unsigned.UInt8.t CArray.t =
  let arr = CArray.make uint8_t (String.length s) in
  for i = 0 to String.length s - 1 do
    CArray.set arr i (Unsigned.UInt8.of_int (Char.code s.[i]))
  done;
  arr


let password = "secret_password"
let salt = "random_salt"


(* Output buffer to hold derived key *)
let out_len = 64  (* desired output length in bytes *)
let output_buf = CArray.make uint8_t out_len



(* Convert OCaml strings to C pointers (unsigned char pointers) *)
let password_buf = str_to_uint8_carray password
let salt_buf = str_to_uint8_carray salt


let () =
  let result = crypto_test
    password_buf
    (CArray.length password_buf)  (* password length *)
    salt_buf
    (CArray.length salt_buf)      (* salt length *)
    16384
    8
    1
    output_buf
    out_len
  in
  Printf.printf "crypto_scrypt returned %d\n" result;

  (* print the derived key as hex *)
  Printf.printf "Derived key: ";
  for i = 0 to out_len - 1 do
    Printf.printf "%02x" (Unsigned.UInt8.to_int (CArray.get output_buf i))
  done;
  Printf.printf "\n"