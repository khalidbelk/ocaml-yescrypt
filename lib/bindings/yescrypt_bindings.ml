(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: lib_gen/yescrypt_bindings.ml
*)

open Ctypes

module Functions (F: Cstubs.FOREIGN) = struct
  open F
  let crypto_scrypt =
    F.foreign "crypto_scrypt" (
      ptr uint8_t        (* passwd *)
      @-> size_t         (* passwdlen *)
      @-> ptr uint8_t    (* salt *)
      @-> size_t         (* saltlen *)
      @-> uint64_t       (* N *)
      @-> uint32_t       (* r *)
      @-> uint32_t       (* p *)
      @-> ptr uint8_t    (* buf *)
      @-> size_t         (* buflen *)
      @-> returning int
    )

end