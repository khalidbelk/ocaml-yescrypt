(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: lib_gen/yescrypt_bindings.ml
*)

open Ctypes

module Types = Yescrypt_types.Types

module Functions (F: Cstubs.FOREIGN) = struct
  open F

  let crypto_scrypt =
    F.foreign "crypto_scrypt" (
      ptr uint8_t               (*  passwd    *)
      @-> size_t                (*  passwdlen *)
      @-> ptr uint8_t           (*  salt      *)
      @-> size_t                (*  saltlen   *)
      @-> uint64_t              (*  N         *)
      @-> uint32_t              (*  r         *)
      @-> uint32_t              (*  p         *)
      @-> ptr uint8_t           (*  buf       *)
      @-> size_t                (*  buflen    *)
      @-> returning int
    )

  let yescrypt_init_shared =
    F.foreign "yescrypt_init_shared" (
      ptr Types.yescrypt_shared_t         (*  shared   *)
      @-> ptr uint8_t                     (*  seed     *)
      @-> size_t                          (*  seedlen  *)
      @-> ptr Types.yescrypt_params_t     (*  params   *)
      @-> returning int
    )

  let yescrypt_digest_shared =
    F.foreign "yescrypt_digest_shared" (
      ptr Types.yescrypt_shared_t         (*  shared  *)
      @-> returning (ptr Types.yescrypt_binary_t)
    )

  let yescrypt_free_shared =
    F.foreign "yescrypt_free_shared" (
      ptr Types.yescrypt_shared_t        (* shared  *)
      @-> returning int
    )

  let yescrypt_init_local =
    F.foreign "yescrypt_init_local" (
      ptr Types.yescrypt_local_t        (* local *)
      @-> returning int
    )

  let yescrypt_free_local =
    F.foreign "yescrypt_free_local" (
      ptr Types.yescrypt_local_t        (* local *)
      @-> returning int
    )

  let yescrypt_kdf =
    F.foreign "yescrypt_kdf" (
      ptr Types.yescrypt_shared_t       (*  shared    *)
      @-> ptr Types.yescrypt_local_t    (*  local     *)
      @-> ptr uint8_t                   (*  passwd    *)
      @-> size_t                        (*  passwdlen *)
      @-> ptr uint8_t                   (*  salt      *)
      @-> size_t                        (*  saltlen   *)
      @-> ptr Types.yescrypt_params_t   (*  params    *)
      @-> ptr uint8_t                   (*  buf       *)
      @-> size_t                        (*  buflen    *)
      @-> returning int
    )

  let yescrypt_r =
    F.foreign "yescrypt_r" (
      ptr Types.yescrypt_shared_t       (*  shared    *)
      @-> ptr Types.yescrypt_local_t    (*  local     *)
      @-> ptr uint8_t               (*  passwd    *)
      @-> size_t                    (*  passwdlen *)
      @-> ptr uint8_t               (*  setting   *)
      @-> ptr Types.yescrypt_binary_t   (*  key       *)
      @-> ptr uint8_t               (*  buf       *)
      @-> size_t                    (*  buflen    *)
      @-> returning (ptr uint8_t)
    )

  let yescrypt =
    F.foreign "yescrypt" (
      ptr uint8_t                   (*  passwd  *)
      @-> ptr uint8_t               (*  setting *)
      @-> returning (ptr uint8_t)
    )

  let yescrypt_reencrypt =
    F.foreign "yescrypt_reencrypt" (
      ptr uint8_t                   (*  hash      *)
      @-> ptr Types.yescrypt_binary_t   (*  from_key  *)
      @-> ptr Types.yescrypt_binary_t   (*  to_key    *)
      @-> returning (ptr uint8_t)
    )

  let yescrypt_encode_params_r =
    F.foreign "yescrypt_encode_params_r" (
      ptr Types.yescrypt_params_t       (*  params  *)
      @-> ptr uint8_t               (*  src     *)
      @-> size_t                    (*  srclen  *)
      @-> ptr uint8_t               (*  buf     *)
      @-> size_t                    (*  buflen  *)
      @-> returning (ptr uint8_t)
    )

  let yescrypt_encode_params =
    F.foreign "yescrypt_encode_params" (
      ptr Types.yescrypt_params_t       (*  params  *)
      @-> ptr uint8_t               (*  src     *)
      @-> size_t                    (*  srclen  *)
      @-> returning (ptr uint8_t)
    )


end