{
  description = "nix apps and devshells";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
      systemOutputs = forAllSystems mkOutputs;

      mkApp = drv: {
        type = "app";
        program = lib.getExe drv;
      };

      mkOutputs =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          shellApp = pkgs.writeShellApplication {
            name = "hello-world";
            runtimeInputs = [ pkgs.hello ];
            text = ''
              hello -t
            '';
          };

          shellApp' = pkgs.writeShellApplication {
            name = "drbat";
            runtimeInputs = with pkgs; [
              fzf
              bat
            ];
            text = ''
              fzf --reverse --preview='bat --color=always {}'
            '';
          };
        in
        {
          apps = {
            default = mkApp shellApp;
            alt = mkApp shellApp';
          };
          devShell = pkgs.mkShell {
            packages = [
              shellApp
              shellApp'
            ];
          };
        };

    in
    {
      apps = lib.mapAttrs (_: value: value.apps) systemOutputs;
      devShells = lib.mapAttrs (_: value: { default = value.devShell; }) systemOutputs;
    };
}
