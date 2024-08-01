{
  inputs,
  cell,
}: {
  mai = {
    imports = [
      cell.nixosConfigurations.mai
    ];

    deployment = {
      targetHost = "mai.siki.moe";
      targetPort = 22;
      targetUser = "yousiki";
    };
  };
}
