{
  inputs,
  cell,
}: {
  config,
  lib,
  pkgs,
  ...
}: {
  age.secrets.hakase-tunnel-cert = {
    file = "${inputs.self}/secrets/hakase-tunnel-cert.age";
    owner = "cloudflared";
    group = "cloudflared";
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "hakase-tunnel" = {
        credentialsFile = "${config.age.secrets.hakase-tunnel-cert.path}";
        ingress = {
          "lobe.siki.moe" = "http://localhost:3210";
          "ollama.siki.moe" = "http://localhost:11434";
          "qb.siki.moe" = "http://localhost:8080";
        };
        default = "http_status:404";
      };
    };
  };

  services.qbittorrent = {
    enable = true;
    webui.port = 8080;
    openFirewall = true;
  };

  services.ollama = {
    enable = true;
    acceleration =
      if pkgs.config.cudaSupport
      then "cuda"
      else null;
    host = "0.0.0.0";
    port = 11434;
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };

  age.secrets.lobechat-envs = {
    file = "${inputs.self}/secrets/lobechat.envs.age";
  };

  virtualisation.oci-containers.containers.lobe-chat = {
    image = "docker.siki.moe/lobehub/lobe-chat";
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    environmentFiles = ["${config.age.secrets.lobechat-envs.path}"];
    extraOptions = ["--network=host"];
    autoStart = true;
  };
}
