{
  description = "nix devshells and apps";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      mkDefApp =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          name = "hello-world";
          shellApp = pkgs.writeShellApplication {
            inherit name;
            runtimeInputs = [ pkgs.hello ];
            text = ''
              hello -t
            '';
          };
        in
        {
          app = {
            type = "app";
            program = "${shellApp}/bin/${name}";
          };
          devShell = pkgs.mkShell {
            packages = [ shellApp ];
          };
        };

    in
    {
      apps = forAllSystems (system: {
        default = (mkDefApp system).app;
      });
      devShells = forAllSystems (system: {
        default = (mkDefApp system).devShell;
      });
    };
}
