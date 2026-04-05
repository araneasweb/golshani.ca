{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      lib = nixpkgs.lib;

      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      perSystem = system:
        let
          pkgs = import nixpkgs { inherit system; };
          hpkgs = pkgs.haskellPackages;

          site = hpkgs.callCabal2nix "golshanica" ./. { };

          mkDevApp = name: siteArgs:
            let
              script = pkgs.writeShellApplication {
                inherit name;
                runtimeInputs = [ pkgs.nix ];
                text = ''
                  exec nix develop .#default --command \
                    cabal run site -- ${lib.escapeShellArgs siteArgs} "$@"
                '';
              };
            in
            {
              type = "app";
              program = lib.getExe script;
            };
        in
        {
          packages = {
            default = site;
          };

          apps = {
            default = mkDevApp "build-site" [ "build" ];
            build = mkDevApp "build-site" [ "build" ];
            raw-watch = mkDevApp "raw-site-watch" [ "watch" ];
          };

          devShells = {
            default = hpkgs.shellFor {
              packages = _: [ site ];
              withHoogle = true;

              nativeBuildInputs = [
                hpkgs.cabal-install
                pkgs.haskell-language-server
                hpkgs.hlint
                hpkgs.ormolu
                hpkgs.ghcid
              ];
            };
          };
        };
    in
    {
      packages = forAllSystems (system: (perSystem system).packages);
      apps = forAllSystems (system: (perSystem system).apps);
      devShells = forAllSystems (system: (perSystem system).devShells);
    };
}
