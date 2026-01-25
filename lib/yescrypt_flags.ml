(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: yescrypt_flags.ml - Yescrypt flags (internal)
*)

let worm        = 0x001
let rw          = 0x002
let rounds_3    = 0x000
let rounds_6    = 0x004
let gather_1    = 0x000
let gather_2    = 0x008
let gather_4    = 0x010
let gather_8    = 0x018
let simple_1    = 0x000
let simple_2    = 0x020
let simple_4    = 0x040
let simple_8    = 0x060
let sbox_6k     = 0x000
let sbox_12k    = 0x080
let sbox_24k    = 0x100
let sbox_48k    = 0x180
let sbox_96k    = 0x200
let sbox_192k   = 0x280
let sbox_384k   = 0x300
let sbox_768k   = 0x380

(** Default yescrypt flags (YESCRYPT_RW with good defaults) *)
let defaults = rw lor rounds_6 lor gather_4 lor simple_2 lor sbox_12k
