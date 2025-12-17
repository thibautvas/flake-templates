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
        in
        {
          default =
            let
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
              type = "app";
              program = "${shellApp}/bin/${name}";
            };
        }
      );
    };
}
