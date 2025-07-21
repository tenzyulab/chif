{
  description = "development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
  in {
    devShell = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [ 
        zsh
      ];
      packages = with pkgs; [ 
        nodejs_20
        nodePackages.pnpm
      ];
      shellHook = with pkgs; ''
        if [ -f .env.local ]; then
          set -a
          source .env.local
          set +a
        fi

        exec zsh
      '';
    };
  });
}
