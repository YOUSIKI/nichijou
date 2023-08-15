{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  networking.proxy.default = "http://localhost:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,cn";

  virtualisation.podman.enable = lib.mkForce true;

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      clash = {
        image = "dreamacro/clash:latest";
        ports = [
          "7890:7890"
          "9090:9090"
        ];
        volumes = [
          "/etc/clash:/root/.config/clash"
        ];
        autoStart = true;
      };
    };
  };
}
