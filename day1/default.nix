localFlake:
{ lib, config, self, inputs, ... }: {
  perSystem = { system, ... }: {
    packages.day1 = localFlake.withSystem system
      ({ config, pkgs, ... }: pkgs.callPackage ./day1.nix { });
  };
}
