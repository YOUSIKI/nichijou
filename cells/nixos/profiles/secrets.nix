{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.secrets.clash-config.file = "${inputs.self}/secrets/clash-config.age";
  age.secrets.nas-credentials.file = "${inputs.self}/secrets/nas-credentials.age";
  age.secrets.cloudflare-tunnel-cert.file = "${inputs.self}/secrets/cloudflare-tunnel-cert.age";
}
