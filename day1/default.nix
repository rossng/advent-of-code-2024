localFlake:
{ lib, config, self, inputs, ... }: {
  perSystem = { system, ... }: {
    packages.hello = localFlake.withSystem system
      ({ config, pkgs, ... }: pkgs.callPackage ./day1.nix { });
  };
}
