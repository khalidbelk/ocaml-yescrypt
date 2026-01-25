open Ctypes

module Types  = struct

  type yescrypt_params_t
  type yescrypt_binary_t
  type yescrypt_region_t

  (* Structure: yescrypt_region_t *)
  let yescrypt_region_t : yescrypt_region_t structure typ = structure "yescrypt_region_t"
  let base = field yescrypt_region_t "base" (ptr void)
  let aligned = field yescrypt_region_t "aligned" (ptr void)
  let base_size = field yescrypt_region_t "base_size" size_t
  let aligned_size = field yescrypt_region_t "aligned_size" size_t
  (* End *)

  let () = seal yescrypt_region_t

  (* Aliases for yescrypt_region_t *)
  type yescrypt_shared_t = yescrypt_region_t structure
  type yescrypt_local_t = yescrypt_region_t structure
  (* End *)

  (* Structure: yescrypt_params_t *)
  let yescrypt_params_t : yescrypt_params_t structure typ = structure "yescrypt_params_t"
  let flags = field yescrypt_params_t "flags" uint32_t
  let n = field yescrypt_params_t "N" uint64_t
  let r = field yescrypt_params_t "r" uint32_t
  let p = field yescrypt_params_t "p" uint32_t
  let t = field yescrypt_params_t "t" uint32_t
  let g = field yescrypt_params_t "g" uint32_t
  let nrom = field yescrypt_params_t "NROM" uint64_t
  (* End *)

  let () = seal yescrypt_params_t

  (* Union: yescrypt_binary_t *)
  let yescrypt_binary_t : yescrypt_binary_t union typ = union "yescrypt_binary_t"
  let uc = field yescrypt_binary_t "uc" (array 32 uchar)
  let u64 = field yescrypt_binary_t "u64" (array 4 uint64_t)
  (* End *)

  let () = seal yescrypt_binary_t
end
