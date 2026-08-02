{
  description = "nix outputs";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      perSystem =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          shellApp = pkgs.writeShellApplication {
            name = "hello-world";
            runtimeInputs = [ pkgs.hello ];
            text = "hello -t";
          };
        in
        {
          packages.default = shellApp;
          apps.default = {
            type = "app";
            program = "${shellApp}/bin/${shellApp.name}";
          };
          devShells.default = pkgs.mkShell {
            packages = [ shellApp ];
          };
        };

    in
    lib.genAttrs [ "packages" "apps" "devShells" ] (
      output: forAllSystems (system: (perSystem system).${output})
    );
}
