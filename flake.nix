{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      eachSystem = f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed
          (system: f (import nixpkgs { inherit system; }));

      mkProject = pkgs:
        let
          hpkgs = pkgs.haskellPackages;
          drv = hpkgs.callCabal2nix "golshanica" ./. { };
        in
        {
          inherit hpkgs drv;
        };
    in
    {
      packages = eachSystem (pkgs:
        let
          p = mkProject pkgs;
        in
        {
          default = p.drv;
        });

      devShells = eachSystem (pkgs:
        let
          p = mkProject pkgs;
        in
        {
          default = p.hpkgs.shellFor {
            packages = _: [ p.drv ];
            withHoogle = true;

            nativeBuildInputs = [
              p.hpkgs.cabal-install
              pkgs.haskell-language-server
              p.hpkgs.hlint
              p.hpkgs.ormolu
              p.hpkgs.ghcid
            ];
          };
        });
    };
}
