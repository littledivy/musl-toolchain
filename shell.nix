{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    gcc14
    flex
    bison
    gawk
    texinfo
    wget
    zlib
  ];

  # Don't include unwatned GCC flags
  hardeningDisable = [ "all" ];
}
