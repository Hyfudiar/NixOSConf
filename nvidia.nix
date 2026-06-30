{
  config,
  lib,
  ...
}:
{
  assertions = lib.singleton {
    assertion = config.boot.kernelPackages.kernel.isLTS;
    message = ''
      The nvidia driver can only support the LTS kernel.
      Do not modify `boot.kernelPackages`.
    '';
  };

  # Force Plasma to only use the NVIDIA GPU
 #environment.variables.KWIN_DRM_DEVICES = lib.escape [ ":" ] "/dev/dri/by-path/pci-0000:3c:0.0-card";

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Quadro P520
    open = false;
    branch = "legacy_580";

    powerManagement = {
      # Suspend the full GPU memory
      enable = false;

      # Turn off when not in use
      finegrained = false;
    };
  };

  # These settings are entirely ignored on Wayland, but alas settings like
  # `powermanagement.finegrained` force you to set them anyway.
  #
  # This is one of those cases where the NixOS module is almost as bad as
  # the wikis.
  hardware.nvidia.prime = {
    sync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:60:0:0";
  };
}
