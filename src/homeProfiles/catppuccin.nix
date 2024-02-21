# Catppuccin themes via Home-manager.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  sources = pkgs.callPackage (globals.root + /nvfetcher/generated.nix) {};

  cfg = config.catppuccin;

  flavorAttrs = {
    latte = null;
    frappe = null;
    macchiato = null;
    mocha = null;
  };
in {
  options.catppuccin = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable catppuccin theme.
      '';
    };

    flavor = mkOption {
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      default = "latte";
      description = ''
        The color scheme to use for catppuccin theme.
      '';
    };
  };

  config = mkIf cfg.enable (mkMerge [
    # bat
    (mkIf config.programs.bat.enable {
      programs.bat = {
        config.theme = "catppuccin-${cfg.flavor}";
        themes =
          mapAttrs (n: v: {
            src = sources.catppuccin-bat.src;
            file = "Catppuccin-${n}.tmTheme";
          })
          flavorAttrs;
      };
    })

    # bottom
    (mkIf config.programs.bottom.enable {
      programs.bottom = {
        settings = fromTOML (
          readFile (
            sources.catppuccin-bottom.src + "/themes/${cfg.flavor}.toml"
          )
        );
      };
    })

    # btop
    (mkIf config.programs.btop.enable {
      programs.btop.settings.color_scheme = "catppuccin-${cfg.flavor}";
      home.file =
        mapAttrs'
        (n: v:
          nameValuePair
          ".config/btop/themes/catppuccin-${n}.theme"
          {source = sources.catppuccin-btop.src + "/themes/catppuccin_${n}.theme";})
        flavorAttrs;
    })

    # fzf
    (mkIf config.programs.fzf.enable (
      let
        catppuccin-colors = {
          latte = {
            "bg+" = "#ccd0da";
            "bg" = "#eff1f5";
            "spinner" = "#dc8a78";
            "hl" = "#d20f39";
            "fg" = "#4c4f69";
            "header" = "#d20f39";
            "info" = "#8839ef";
            "pointer" = "#dc8a78";
            "marker" = "#dc8a78";
            "fg+" = "#4c4f69";
            "prompt" = "#8839ef";
            "hl+" = "#d20f39";
          };
          frappe = {
            "bg+" = "#414559";
            "bg" = "#303446";
            "spinner" = "#f2d5cf";
            "hl" = "#e78284";
            "fg" = "#c6d0f5";
            "header" = "#e78284";
            "info" = "#ca9ee6";
            "pointer" = "#f2d5cf";
            "marker" = "#f2d5cf";
            "fg+" = "#c6d0f5";
            "prompt" = "#ca9ee6";
            "hl+" = "#e78284";
          };
          macchiato = {
            "bg+" = "#363a4f";
            "bg" = "#24273a";
            "spinner" = "#f4dbd6";
            "hl" = "#ed8796";
            "fg" = "#cad3f5";
            "header" = "#ed8796";
            "info" = "#c6a0f6";
            "pointer" = "#f4dbd6";
            "marker" = "#f4dbd6";
            "fg+" = "#cad3f5";
            "prompt" = "#c6a0f6";
            "hl+" = "#ed8796";
          };
          mocha = {
            "bg+" = "#313244";
            "bg" = "#1e1e2e";
            "spinner" = "#f5e0dc";
            "hl" = "#f38ba8";
            "fg" = "#cdd6f4";
            "header" = "#f38ba8";
            "info" = "#cba6f7";
            "pointer" = "#f5e0dc";
            "marker" = "#f5e0dc";
            "fg+" = "#cdd6f4";
            "prompt" = "#cba6f7";
            "hl+" = "#f38ba8";
          };
        };
      in {
        programs.fzf.colors = catppuccin-colors."${cfg.flavor}";
      }
    ))

    # gitui
    (mkIf config.programs.gitui.enable {
      programs.gitui.theme = readFile (sources.catppuccin-gitui.src + "/theme/${cfg.flavor}.ron");
    })

    # helix
    (
      mkIf config.programs.helix.enable {
        programs.helix.settings.theme = "catppuccin_${cfg.flavor}";
      }
    )

    # starship
    (mkIf config.programs.starship.enable (
      let
        loader = n:
          fromTOML (readFile (
            sources.catppuccin-starship.src + "/palettes/${n}.toml"
          ));
      in {
        programs.starship.settings =
          {
            palette = "catppuccin_${cfg.flavor}";
          }
          // (loader "${cfg.flavor}");
      }
    ))

    # zellij
    (mkIf config.programs.zellij.enable {
      programs.zellij.settings.theme = "catppuccin-${cfg.flavor}";
    })
  ]);
}
