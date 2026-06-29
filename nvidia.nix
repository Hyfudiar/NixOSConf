{ config, lib, ... }: {
  assertions = lib.singleton {
    assertion = config.boot.kernelPackages.kernel.isLTS;
    message = ''
      The nvidia driver can only support the LTS kernel.
      Do not modify `boot.kernelPackages`.
    '';
  };

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {    
    # Quadro P520
    open = false;
    branch = "legacy_580";

    powerManagement = {
      # Suspend the full GPU memory
      enable = true;

      # Turn off when not in use
      finegrained = true;
    };
  };

  hardware.nvidia.prime = {
    sync.enable = false;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:60:0:0";
  };
}
