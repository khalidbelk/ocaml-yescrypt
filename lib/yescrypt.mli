(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: yescrypt.mli
*)

(** Exception raised when scrypt operations fail *)
exception Crypto_scrypt_error of string

(** [crypto_scrypt ~passwd ~salt ~n ~r ~p ~buf_len] computes scrypt KDF
    and returns the result as a hexadecimal string.

    @param passwd The password string
    @param salt The salt string
    @param n CPU/memory cost parameter (must be power of 2 > 1)
    @param r Block size parameter
    @param p Parallelization parameter
    @param buf_len Output length in bytes
    @return The derived key as a hexadecimal string
    @raise Crypto_scrypt_error if the operation fails
*)
val crypto_scrypt :
  passwd:string ->
  salt:string ->
  n:int ->
  r:int ->
  p:int ->
  buf_len:int ->
  string

(** [crypto_scrypt_bytes ~passwd ~salt ~n ~r ~p ~buf_len] computes scrypt KDF
    and returns the result as raw bytes.

    @param passwd The password string
    @param salt The salt string
    @param n CPU/memory cost parameter (must be power of 2 > 1)
    @param r Block size parameter
    @param p Parallelization parameter
    @param buf_len Output length in bytes
    @return The derived key as raw bytes
    @raise Crypto_scrypt_error if the operation fails
*)
val crypto_scrypt_bytes :
  passwd:string ->
  salt:string ->
  n:int ->
  r:int ->
  p:int ->
  buf_len:int ->
  bytes

(** Exception raised when yescrypt operations fail *)
exception Yescrypt_error of string

(** [yescrypt ~passwd ~salt ~n ~r ~p] computes a yescrypt hash.

    This is the main function for password hashing with yescrypt.
    Uses recommended default flags (YESCRYPT_RW with optimal settings).

    {b Note:} This function is NOT thread-safe due to the underlying C implementation.

    @param passwd The password string
    @param salt The salt string
    @param n CPU/memory cost parameter (must be power of 2 > 1)
    @param r Block size parameter
    @param p Parallelization parameter
    @return The encoded hash string (includes salt and params, suitable for storage)
    @raise Yescrypt_error if the operation fails.

    {b Example:}
    {[
      let hash = Yescrypt.yescrypt
        ~passwd:"password123"
        ~salt:"randomsalt"
        ~n:4096 ~r:32 ~p:1
    ]}
*)
val yescrypt :
  passwd:string ->
  salt:string ->
  n:int ->
  r:int ->
  p:int ->
  string
