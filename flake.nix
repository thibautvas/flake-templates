{
  description = "nix templates by thibautvas";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.python-template = {
    url = "path:./templates/python";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      python-template,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      templateNames = builtins.attrNames (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./templates)
      );

      mkTemplate = name: {
        description = "flake template for ${name}";
        path = ./templates/${name};
      };

      perSystem =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mkApp =
            name:
            let
              shellApp = pkgs.writeShellApplication {
                name = "init-${name}";
                runtimeInputs = [ pkgs.gitMinimal ];
                text = ''
                  nix flake init -t "${self}#${name}"
                  cp --update=none -v ${self}/flake.lock . # not pretty but keeps lockfile unique
                  git init
                  git add -A
                  git commit -m init
                '';
              };
            in
            {
              type = "app";
              program = "${shellApp}/bin/${shellApp.name}";
            };
        in
        {
          apps = lib.genAttrs templateNames mkApp // {
            default = mkApp "packages";
          };

          packages = {
            venv = python-template.packages.${system}.default;
          };
        };

    in
    {
      templates = lib.genAttrs templateNames mkTemplate // {
        default = self.templates.packages;
      };

      apps = forAllSystems (system: (perSystem system).apps);

      packages = forAllSystems (system: (perSystem system).packages);
    };
}
