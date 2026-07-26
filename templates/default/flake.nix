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
          name = "my-app";
          shellApp = pkgs.writeShellApplication {
            inherit name;
            runtimeInputs = with pkgs; [
              fzf
              chafa
            ];
            text = "";
          };
        in
        {
          packages.default = shellApp;
          apps.default = {
            type = "app";
            program = "${shellApp}/bin/${name}";
          };
          devShells.default = pkgs.mkShell {
            packages = [ shellApp ];
          };
        };

    in
    {
      packages = forAllSystems (system: (perSystem system).packages);
      apps = forAllSystems (system: (perSystem system).apps);
      devShells = forAllSystems (system: (perSystem system).devShells);
    };
}
