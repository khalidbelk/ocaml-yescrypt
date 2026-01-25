module Y = Yescrypt

let () =
  (* Classic scrypt *)
  (try
    let derived_key = Y.crypto_scrypt ~passwd:"hello" ~salt:"randomsalt"
      ~n:4 ~r:8 ~p:1 ~buf_len:64
    in
    Printf.printf "scrypt:   %s\n" derived_key
  with Y.Crypto_scrypt_error msg ->
    Printf.eprintf "scrypt error: %s\n" msg);

  (* Yescrypt *)
  (try
    let hash = Y.yescrypt ~passwd:"hello" ~salt:"randomsalt"
      ~n:4096 ~r:32 ~p:1
    in
    Printf.printf "yescrypt: %s\n" hash
  with Y.Yescrypt_error msg ->
    Printf.eprintf "yescrypt error: %s\n" msg)