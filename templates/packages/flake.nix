{
  description = "nix packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pack = pkgs.hello;
        in
        {
          packages.default = pack;
        };

    in
    {
      packages = forAllSystems (system: (perSystem system).packages);
    };
}
