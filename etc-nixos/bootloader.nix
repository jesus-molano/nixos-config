{
  lib,
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  # Bootloader
#  boot.loader.systemd-boot.enable = lib.mkForce false;
#  boot.loader.grub = {
#    enable = lib.mkForce true;
#    device = "nodev";
#    efiSupport = true;
#    useOSProber = true;
#  };

#  # Bootloader settings
#  boot.loader.efi = {
#    canTouchEfiVariables = true;
#    efiSysMountPoint = "/boot";
#  };
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

}

