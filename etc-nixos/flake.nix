/*

Search Terms:

  !hdw -> Hardware (A device.)

*/



{
  description = "Jesus NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = let
      fullname = "Jesus Molano";
      username = "vekpol";
      editor = "hx";
      browser = "qutebrowser";
    in {

      # !hdw laptop
      laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs;
          inherit system;
          inherit username fullname;
          inherit editor browser;
        };

        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = {
                home = {
                  username = username;
                  homeDirectory = "/home/${username}";
                  # do not change this value
                  stateVersion = "23.05";
                };

                # Let Home Manager install and manage itself.
                programs.home-manager.enable = true;
              };
            };
          }
          ./machines/laptop/config.nix
        ];
      };

      # !hdw desktop
      pongo = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs;
          inherit system;
          inherit username fullname;
          inherit editor browser;
        };

        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = {
                home = {
                  username = username;
                  homeDirectory = "/home/${username}";
                  # do not change this value
                  stateVersion = "23.05";
                };

                # Let Home Manager install and manage itself.
                programs.home-manager.enable = true;
              };
            };
          }
          ./machines/desktop/config.nix
        ];
      };
    };
  };
}

