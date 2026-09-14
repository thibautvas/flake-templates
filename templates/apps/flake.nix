{
  description = "nix apps";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      pack = pkgs.hello;

    in
    {
      packages.${system}.default = pack;
      apps.${system}.default = {
        type = "app";
        program = "${pack}/bin/${pack.pname}";
      };
    };
}
