{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    flake.inputs.nix-index-database.hmModules.nix-index
    flake.outputs.homeModules.catppuccin
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
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

  programs.command-not-found.enable = false;

  programs.exa = {
    enable = true;
    enableAliases = true;
    icons = true;
    git = true;
  };

  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
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
      core.editor = "hx";
    };
    ignores =
      pipe
      (pkgs.fetchurl {
        url = "https://www.toptal.com/developers/gitignore/api/linux,macos,windows,vim,emacs,visualstudiocode";
        sha256 = "sha256-+k97G8+1ECyANjXyxCgLAH2HfL18xZhO4WaVetrasoU=";
      }) [
        (splitString "\n")
        (filter (s: s != "" && !hasPrefix "#" s))
      ];
  };

  programs.gitui.enable = true;

  programs.helix = {
    enable = true;
    languages = {
      # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command = "''${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=''${typescript}/lib/node_modules/typescript/lib"];
      };
      language = map (name: {
        name = name;
        auto-format = true;
      }) ["rust" "python" "nix"];
    };
    settings.editor = {
      line-number = "relative";
      lsp.display-messages = true;
    };
  };

  programs.htop.enable = true;

  programs.jq.enable = true;

  programs.lazygit.enable = true;

  programs.neovim.enable = true;

  programs.nix-index.enable = true;

  programs.nix-index-database.comma.enable = true;

  programs.ripgrep.enable = true;

  programs.starship = {
    enable = true;
    settings = {};
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableIonIntegration = true;
    enableNushellIntegration = true;
    enableTransience = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = let
      gpakosz-tmux = pkgs.fetchFromGitHub {
        owner = "gpakosz";
        repo = ".tmux";
        rev = "master";
        sha256 = "sha256-LkoRWds7PHsteJCDvsBpZ80zvlLtFenLU3CPAxdEHYA=";
      };
    in
      concatStringsSep "\n" [
        (readFile (gpakosz-tmux + "/.tmux.conf"))
        (readFile (gpakosz-tmux + "/.tmux.conf.local"))
      ];
  };

  programs.vim.enable = true;

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
    shellAliases = {
    };
    initExtra = ''
      bindkey "\e[1;3D" backward-word # ⌥←
      bindkey "\e[1;3C" forward-word # ⌥→
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
  };

  programs.kitty = {
    enable = true;
    settings = {
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else '''}";
    };
    keybindings = {};
    environment = {};
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    extraConfig = ''
      font_family                 CaskaydiaCove Nerd Font Propo
      font_size                   12.0
    '';
  };

  programs.catppuccin.enable = true;
  programs.catppuccin.palette = "frappe";

  home.packages = with pkgs; [
    alejandra
    home-manager
    nil
    nodejs
    nvfetcher
    rnix-lsp
    thefuck
  ];

  home.sessionPath = [
    "/usr/local/bin"
  ];
}
