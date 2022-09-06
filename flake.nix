{
  description = "Bats-file helper library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        bats-file = pkgs.stdenv.mkDerivation {
          name = "bats-file";
          src = pkgs.fetchgit {
            url = "https://github.com/bats-core/bats-file.git";
            rev = "v0.3.0";
            sha256 = "sha256-3xevy0QpwNZrEe+2IJq58tKyxQzYx8cz6dD2nz7fYUM=";
          };
          installPhase = ''
            mkdir -p $out/bin
            cp ./load.bash $out/bin/$name.load.bash
            cp -r ./src $out/bin/
          '';
        };
        packages = { default = bats-file; };
      });
}
