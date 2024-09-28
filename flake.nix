{
  description = "The GenShinGothic font";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-shin-gothic = {
      url = "https://ftp.iij.ad.jp/pub/osdn.jp/users/8/8634/genshingothic-20150607.7z";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      gen-shin-gothic,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "gen-shin-gothic";
            version = "1.002.20150531";

            src = gen-shin-gothic;

            nativeBuildInputs = [ pkgs.p7zip ];

            unpackPhase = ''
              runHook preUnpack

              7z x $src -ogen-shin-gothic

              runHook postUnpack
            '';

            installPhase = ''
              runHook preInstall

              install -m644 -D --target $out/share/fonts/truetype/gen-shin-gothic gen-shin-gothic/GenShinGothic-*.ttf

              runHook postInstall
            '';
          };
        };
      }
    );
}
