{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.secrets.nas-credentials.file = "${inputs.self}/secrets/nas-credentials.age";
}
