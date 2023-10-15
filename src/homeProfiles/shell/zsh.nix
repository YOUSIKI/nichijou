{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    enableAutosuggestions = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "copyfile"
        "copypath"
        "docker"
        "fzf"
        "git"
        "gitignore"
        "history"
        "python"
        "rust"
        "thefuck"
        "zsh-interactive-cd"
      ];
    };
    initExtra = ''
      bindkey "\e[1;3D" backward-word # ⌥←
      bindkey "\e[1;3C" forward-word # ⌥→
    '';
  };

  home.packages = with pkgs; [
    fzf
    thefuck
  ];
}
