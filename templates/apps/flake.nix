{
  description = "nix apps";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

    in
    {
      apps = forAllSystems (
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
          default = {
            type = "app";
            program = "${shellApp}/bin/${shellApp.name}";
          };
        }
      );
    };
}
