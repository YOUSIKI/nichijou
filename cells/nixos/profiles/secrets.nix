{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.secrets = {
    clash-config.file = "${inputs.self}/secrets/clash-config.age";
    nas-credentials.file = "${inputs.self}/secrets/nas-credentials.age";
    hakase-tunnel-cert = {
      file = "${inputs.self}/secrets/hakase-tunnel-cert.age";
      owner = "cloudflared";
      group = "cloudflared";
    };
  };
}
