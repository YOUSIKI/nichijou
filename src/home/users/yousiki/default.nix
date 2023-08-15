{
  inputs,
  cell,
  ...
}: {
  home.username = "yousiki";

  programs.git = {
    userName = "yousiki";
    userEmail = "you.siki@outlook.com";
  };

  imports = [
    cell.homeProfiles.base
    cell.homeProfiles.rust
    cell.homeProfiles.shell
  ];
}
