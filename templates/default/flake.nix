{
  description = "nix devshells and packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      mkPackage =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          name = "template";

        in
        rec {
          pack = pkgs.writeShellApplication {
            inherit name;
            runtimeInputs = [ pkgs.hello ];
            text = ''
              hello -t
            '';
          };

          dev = pkgs.mkShell {
            inherit name;
            packages = [ pack ];
          };
        };

    in
    {
      devShells = forAllSystems (system: {
        default = (mkPackage system).dev;
      });

      packages = forAllSystems (system: {
        default = (mkPackage system).pack;
      });
    };
}
