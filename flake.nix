{
  description = "nix templates by thibautvas";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

    in
    {
      templates =
      let
        mkTemplate = name: {
          description = "flake template for ${name}";
          path = ./templates/${name};
        };

      in
        lib.genAttrs [
          "default"
          "devshells"
          "packages"
          "python"
          "python-ds"
        ] mkTemplate;
    };
}
