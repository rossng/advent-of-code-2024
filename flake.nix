{
  description = "Advent of Code 2024";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        packages.aarch64-darwin.hello =
          nixpkgs.legacyPackages.aarch64-darwin.hello;
        packages.aarch64-darwin.default = self.packages.aarch64-darwin.hello;
      };
      systems = [ "x86_64-linux" "aarch64-darwin" ];
    };
}
