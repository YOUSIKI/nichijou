{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
  ];
}
