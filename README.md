# ocaml-yescrypt

## What is Yescrypt?

Yescrypt is a scalable, **password-hashing** function and a **key-derivation** function (**KDF**) designed by Alexander Peslyak, also known as Solar Designer, to be highly resistant to hardware-accelerated brute-force attacks. As an evolution of the scrypt algorithm, it introduces enhanced memory-hardness and "strongly sequential" processing, which effectively thwarts large-scale cracking attempts using GPUs, FPGAs, and ASICs.

It has been adopted as the default password-hashing scheme for several major Linux distributions, including Debian, Ubuntu, and Fedora. In these systems, Yescrypt is identifiable in the `/etc/shadow` file by the `$y$` prefix. ([Wikipedia](https://en.wikipedia.org/wiki/Yescrypt))

This library provides a relatively abstract and easy-to-use API for integrating Yescrypt into OCaml programs.

## Documentation

You can find the [API documentation here](https://khalidbelk.github.io/ocaml-yescrypt/ocaml-yescrypt/index.html).

## Installation

To install **ocaml-yescrypt** via opam, execute the following command:

```
opam pin add -y git+https://github.com/khalidbelk/ocaml-yescrypt.git
```

> Note: this package needs the **libffi-dev** and **pkg-config** system dependencies. The names of those libraries may vary between distros / on MacOS.

## Example

Here's a quick example of how to use Yescrypt:

```ocaml
let () =
    let hash = Yescrypt.yescrypt ~passwd:"galaxy2galaxy" ~salt:"hitechjazz"
        ~n:4 ~r:8 ~p:1
    in
    Printf.printf "Result: %s\n" hash
```
**Output**:
```
Result: $y$j25..$cZ4RZB4Oe3aSu/$wE7WgfjiSoHWc95Ob0Z7SdhW9Ygqx3RtqKp8ngTKkL4
```


## License

The C implementations used in this library are based on the work of Colin Percival (scrypt) and Alexander Peslyak (yescrypt).

Additional credit goes to Jeremy Yallop for the Ctypes library used to generate the bindings.

This project is licensed under the **Apache 2.0** License - see the [LICENSE](LICENSE) file for details.
