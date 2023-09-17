{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  libnvidia-container = with pkgs; callPackage "${flake.inputs.nixpkgs}/pkgs/applications/virtualization/libnvidia-container" {};
in {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = mkForce true; # required by nvidia-docker.
  virtualisation.docker = {
    enableNvidia = true;
    daemon.settings.default-runtime = "nvidia";
  };
  programs.hyprland.enableNvidiaPatches = true;
  environment.systemPackages = with pkgs; [
    nvitop
    nvtop
    python311Packages.gpustat
  ];
  # virtualisation.lxd.package = (
  #   pkgs.lxd.override {
  #     lxd-unwrapped = pkgs.lxd-unwrapped.overrideAttrs (
  #       oldAttrs: {
  #         postPatch = ''
  #           ${oldAttrs.postPatch}
  #           substituteInPlace lxd/instance/drivers/driver_lxc.go \
  #             --replace "nvidia-container-cli" "${libnvidia-container}/bin/nvidia-container-cli"
  #         '';
  #       }
  #     );
  #   }
  # );
  # systemd.services.lxd = {
  #   environment = let
  #     path =
  #       pkgs.lib.makeBinPath
  #       (with pkgs; [which libnvidia-container util-linux]);
  #     hook =
  #       (
  #         pkgs.srcOnly {
  #           name = "lxc-hooks";
  #           src = "${pkgs.lxc}/share/lxc/hooks";
  #           nativeBuildInputs = [pkgs.makeWrapper];
  #         }
  #       )
  #       .overrideAttrs (
  #         oldAttrs: {
  #           installPhase = ''
  #             ${oldAttrs.installPhase}
  #             wrapProgram $out/nvidia --prefix PATH : ${path}
  #           '';
  #         }
  #       );
  #   in {
  #     LXD_LXC_HOOK = "${hook}";
  #   };
  # };
}
