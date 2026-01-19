Prebuilt distribution of Rich Felker's [musl-cross-make](https://github.com/richfelker/musl-cross-make) toolchains for Linux x64 and macOS arm64:
- `armv7-linux-musleabihf`
- `aarch64-linux-musl`
- `x86_64-linux-musl`
- `i686-linux-musl`
- `aarch64_be-linux-musl`
- `arm-linux-musleabi`
- `arm-linux-musleabihf`
- `armeb-linux-musleabi`
- `armeb-linux-musleabihf`
- `riscv64-linux-musl`

### Releases

Releases are versioned as `v(MUSL_VER)-gcc(GCC_VER)`

Download prebuilds for your host and target toolchain from [GitHub releases](https://github.com/littledivy/musl-toolchain/releases). Artifacts are named as `(TARGET)-(HOST).tar.gz`, eg: `aarch64-linux-musl-macos-14`

### Building from source

Clone this repo with submodules. `config.mak` is the default configuration for the prebuilds.

#### macOS

Make sure you have XCode 15 or above. Use nix-darwin to install dependencies:
```sh
nix develop
./build.sh # Build all targets (takes long time!)
```

macOS arm64 is not officially supported by `musl-cross-make`. This repo may include external patches to compile specific GCC versions on macOS

### Linux

Same as compiling `musl-cross-make` directly from source. `build.sh` will compile all toolchains.
