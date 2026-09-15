{
  description = "python sandbox using nixpkgs";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          python = pkgs.python3.withPackages (
            ps: with ps; [
              pandas
              scikit-learn
              seaborn
              statsmodels
            ]
          );

        in
        {
          packages.default = python;
        };

    in
    {
      packages = forAllSystems (system: (perSystem system).packages);
    };
}
