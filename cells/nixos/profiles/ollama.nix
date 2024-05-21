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
    listenAddress = "127.0.0.1:11434";
  };
}
