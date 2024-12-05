{
  description = "Advent of Code 2024";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts }:
    flake-parts.lib.mkFlake { inherit inputs; }
    ({ withSystem, flake-parts-lib, ... }: {
      imports = let
        inherit (flake-parts-lib) importApply;
        day1 = importApply ./day1 { inherit withSystem importApply; };
      in [ day1 ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { pkgs, self', ... }: { };
    });
}
