{
  inputs,
  cell,
}: {pkgs, ...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
  };

  programs.bottom.enable = true;

  programs.btop.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    icons = true;
    git = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    tmux.enableShellIntegration = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    extensions = with pkgs; [
      gh-actions-cache
      gh-cal
      gh-dash
      gh-eco
      gh-markdown-preview
    ];
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    userName = "yousiki";
    userEmail = "you.siki@outlook.com";
    extraConfig = {
      pull.rebase = false;
      push.followTags = true;
    };
  };

  programs.gitui.enable = true;

  programs.helix = {
    enable = true;
    languages = {
      language-server = {};
      language =
        map
        (name: {
          name = name;
          auto-format = true;
        }) ["rust" "python" "nix"];
    };
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };

  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    fuzzySearchFactor = 3;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableIonIntegration = true;
    enableNushellIntegration = true;
    enableTransience = true;
    settings.format = "$all";
  };

  programs.tmux.enable = true;

  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
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
        "shell-proxy"
        "thefuck"
        "zoxide"
        "zsh-interactive-cd"
      ];
    };
    initExtra = ''
      bindkey "\e[1;3D" backward-word
      bindkey "\e[1;3C" forward-word

      if [[ -f ~/.orbstack/shell/init.zsh ]]; then
        source ~/.orbstack/shell/init.zsh 2>/dev/null || :
      fi
    '';
    sessionVariables = {
      SHELLPROXY_URL =
        if pkgs.stdenv.isDarwin
        then "http://127.0.0.1:6152"
        else "http://127.0.0.1:7890";
      SHELLPROXY_NO_PROXY = "localhost,127.0.0.1,edu.cn,yousiki.top";
    };
  };
}
