{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.ollama;
in {
  options.${namespace}.programs.ollama = {
    enable = lib.mkEnableOption "Whether to enable ollama";
    acceleration = lib.mkOption {
      type = lib.types.enum ["cpu" "cuda"];
      default = "cuda";
      description = "The acceleration method to use for ollama";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = cfg.acceleration;
      openFirewall = true;
    };
  };
}
