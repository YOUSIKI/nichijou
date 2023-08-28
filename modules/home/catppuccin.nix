{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  cfg = config.programs.catppuccin;
in {
  options.programs.catppuccin = {
    enable = mkEnableOption {
      description = "Enable catppuccin theme";
    };

    palette = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = "frappe";
      example = "frappe";
    };
  };

  config = mkIf cfg.enable (
    mkMerge [
      ( # bat
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
        in {
          programs.bat = mkIf config.programs.bat.enable {
            config.theme = "catppuccin";
            themes.catppuccin = readFile (github + "/Catppuccin-${cfg.palette}.tmTheme");
          };
        }
      )
      ( # bottom
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bottom";
            rev = "main";
            sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
          };
        in
          mkIf config.programs.bottom.enable {
            home.file.".config/bottom/bottom.toml".source = github + "/themes/${cfg.palette}.toml";
          }
      )
      ( # btop
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "btop";
            rev = "main";
            sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
          };
        in
          mkIf config.programs.btop.enable {
            programs.btop.settings.color_scheme = "catppuccin";
            home.file.".config/btop/themes/catppuccin.theme".source = github + "/themes/catppuccin_${cfg.palette}.theme";
          }
      )
      ( # exa
        let
          catppuccin-dict = {
            frappe = ''
              uu=36:
              gu=37:
              sn=32:
              sb=32:
              da=34:
              ur=34:
              uw=35:
              ux=36:
              ue=36:
              gr=34:
              gw=35:
              gx=36:
              tr=34:
              tw=35:
              tx=36:
            '';
          };
        in
          mkIf config.programs.exa.enable {
            home.sessionVariables = {
              EXA_COLORS = catppuccin-dict.${cfg.palette};
            };
          }
      )
      ( # fzf
        let
          catppuccin-dict = {
            frappe = {
              "bg" = "#303446";
              "bg+" = "#414559";
              "fg" = "#c6d0f5";
              "fg+" = "#c6d0f5";
              "header" = "#e78284";
              "hl" = "#e78284";
              "hl+" = "#e78284";
              "info" = "#ca9ee6";
              "marker" = "#f2d5cf";
              "pointer" = "#f2d5cf";
              "prompt" = "#ca9ee6";
              "spinner" = "#f2d5cf";
            };
          };
        in
          mkIf config.programs.fzf.enable {
            programs.fzf.colors = catppuccin-dict.${cfg.palette};
          }
      )
      ( # gitui
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "gitui";
            rev = "main";
            sha256 = "sha256-m6Tjch6A2ZPZ3/muvb/9sEAQUZfjnWqcwyhNVeqPS2c=";
          };
        in
          mkIf config.programs.gitui.enable {
            programs.gitui.theme = readFile (github + "/theme/frappe.ron");
          }
      )
      ( # helix
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "helix";
            rev = "main";
            sha256 = "sha256-0UzXe1qBugR6Saoo/vYYn5wxI/v9gjvYCCSYuA4XtiU=";
          };
        in
          mkIf config.programs.helix.enable {
            programs.helix.themes.catppuccin = fromTOML (readFile (github + "/themes/default/catppuccin_${cfg.palette}.toml"));
            programs.helix.settings.theme = "catppuccin";
          }
      )
      ( # lazygit
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "lazygit";
            rev = "main";
            sha256 = "sha256-9BBmWRcjNaJE9T0RKVEJaSnkrbMom0CLYE8PzAT6yFw=";
          };
        in
          mkIf config.programs.lazygit.enable {
            home.file.".config/lazygit/config.yml".text =
              "gui:\n"
              + (
                pipe
                (github + "/themes/${cfg.palette}.yml")
                [
                  readFile
                  (splitString "\n")
                  (map (s: "  " + s))
                  (concatStringsSep "\n")
                ]
              );
          }
      )
      ( # kitty
        let
          github = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "kitty";
            rev = "main";
            sha256 = "sha256-uZSx+fuzcW//5/FtW98q7G4xRRjJjD5aQMbvJ4cs94U=";
          };
        in
          mkIf config.programs.kitty.enable {
            programs.kitty.extraConfig = readFile (github + "/themes/${cfg.palette}.conf");
          }
      )
    ]
  );
}
