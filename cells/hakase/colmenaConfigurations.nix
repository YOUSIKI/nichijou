{
  inputs,
  cell,
}: {
  hakase = {
    imports = [
      cell.nixosConfigurations.hakase
    ];

    deployment = {
      targetHost = "hakase.siki.moe";
      targetPort = 22;
      targetUser = "yousiki";
    };
  };
}
