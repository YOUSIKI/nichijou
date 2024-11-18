# My favorite terminal shell: zsh
{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.zsh;

  plugins =
    [
      "copyfile"
      "copypath"
      "docker"
      "git"
      "gitignore"
      "history"
      "python"
      "rust"
      "shell-proxy"
      "zsh-interactive-cd"
    ]
    ++ (lib.optional config.programs.fzf.enable "fzf")
    ++ (lib.optional config.programs.zoxide.enable "zoxide");
in {
  options.${namespace}.programs.terminal.zsh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable zsh.";
    };
  };

  config = lib.mkIf cfg.enable {
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
        inherit plugins;
      };
      initExtra = ''
        bindkey "\e[1;3D" backward-word
        bindkey "\e[1;3C" forward-word

        if [[ -f ~/.orbstack/shell/init.zsh ]]; then
          source ~/.orbstack/shell/init.zsh 2>/dev/null || :
        fi
      '';
    };
  };
}
