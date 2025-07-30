(*
  ocaml-yescrypt - OCaml bindings for the Yescrypt KDF
  Khalid B. | @khalidbelk, 2025
  File: lib_gen/yescrypt_bindgen.ml
*)

let () =
  let fmt_c = Format.formatter_of_out_channel (open_out "yescrypt_stubs.c") in
  Format.fprintf fmt_c "#include \"yescrypt.h\"@.";
  Cstubs.write_c fmt_c ~prefix:"caml_yescrypt" (module Yescrypt_bindings.Functions);

  let fmt_ml = Format.formatter_of_out_channel (open_out "yescrypt_generated.ml") in
  Cstubs.write_ml fmt_ml ~prefix:"caml_yescrypt" (module Yescrypt_bindings.Functions)
