{
  inputs,
  cell,
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  l = builtins // lib;

  sources = pkgs.callPackage "${inputs.self}/nvfetcher/generated.nix" {};

  catppuccin-fzf-colors = {
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
  options = {
    bee.home-catppuccin.flavor = l.mkOption {
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      default = "mocha";
      description = ''
        The color scheme to use for catppuccin theme.
      '';
    };
  };

  config = let
    flavor = config.bee.home-catppuccin.flavor;
    flavors = ["latte" "frappe" "macchiato" "mocha"];
  in {
    programs.bat = {
      config.theme = "catppuccin-${flavor}";
      themes = l.genAttrs flavors (n: {
        src = sources.catppuccin-bat.src;
        file = "Catppuccin-${n}.tmTheme";
      });
    };

    programs.bottom.settings = l.fromTOML (
      l.readFile "${sources.catppuccin-bottom.src}/themes/${flavor}.toml"
    );

    programs.btop.settings.color_scheme = "catppuccin-${flavor}";
    home.file =
      l.pipe
      flavors
      [
        (l.map (
          n:
            l.nameValuePair
            ".config/btop/themes/catppuccin-${n}.theme"
            {source = "${sources.catppuccin-btop.src}/themes/catppuccin_${n}.theme";}
        ))
        l.listToAttrs
      ];

    programs.fzf.colors = catppuccin-fzf-colors."${flavor}";

    programs.gitui.theme = l.readFile "${sources.catppuccin-gitui.src}/theme/${flavor}.ron";

    programs.helix.settings.theme = "catppuccin_${flavor}";

    programs.starship.settings =
      {palette = "catppuccin_${flavor}";}
      // l.fromTOML (l.readFile "${sources.catppuccin-starship.src}/palettes/${flavor}.toml");

    programs.zellij.settings.theme = "catppuccin-${flavor}";
  };
}
