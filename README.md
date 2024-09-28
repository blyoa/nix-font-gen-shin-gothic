# nix-font-gen-shin-gothic

This is a Nix flake for the [Gen Shin Gothic（源真ゴシック）](http://jikasei.me/font/genshin/)font.


## Example Usage with Home Manager

```nix
{
  description = "Example configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gen-shin-gothic.url = "github:blyoa/nix-font-gen-shin-gothic";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      gen-shin-gothic,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.packages = [
              gen-shin-gothic.packages.${system}.default
            ];
          }
        ];
      };
    };
}
```
