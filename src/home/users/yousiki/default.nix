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
    cell.homeProfiles.cc
    cell.homeProfiles.python
    cell.homeProfiles.rust
    cell.homeProfiles.shell
  ];
}
