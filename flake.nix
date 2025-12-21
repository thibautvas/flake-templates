{
  description = "nix templates by thibautvas";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    {
      templates =
        let
          mkTemplate = name: {
            description = "flake template for ${name}";
            path = ./templates/${name};
          };

        in
        nixpkgs.lib.genAttrs [
          "default"
          "apps"
          "devshells"
          "python"
          "python-ds"
        ] mkTemplate;
    };
}
