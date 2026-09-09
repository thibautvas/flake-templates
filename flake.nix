{
  description = "nix templates by thibautvas";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      mkTemplate = name: {
        description = "flake template for ${name}";
        path = ./templates/${name};
      };

    in
    {
      templates =
        lib.genAttrs [
          "apps"
          "devshells"
          "packages"
          "python"
        ] mkTemplate
        // {
          default = self.templates.packages;
        };
    };
}
