{
  inputs,
  cell,
}: {pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration =
      if pkgs.config.cudaSupport
      then "cuda"
      else null;
    listenAddress = "0.0.0.0:11434";
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };
  networking.firewall.allowedTCPPorts = [11434];
}
