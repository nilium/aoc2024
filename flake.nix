{
  description = "Tools for aoc2024 stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    uiua.url = "github:uiua-lang/uiua/0.14.0-rc.3";
    uiua.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    uiua,
  }: let
    inherit (nixpkgs) lib;
    systems = ["x86_64-linux" "aarch64-darwin"];
  in {
    devShells = lib.attrsets.genAttrs systems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = [
          uiua.packages.${system}.default
          # pkgs.uiua
        ];
      };
    });
  };
}
