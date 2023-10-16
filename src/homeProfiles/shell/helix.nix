{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  programs.helix = {
    enable = true;
    languages = {
      # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command = "''${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=''${typescript}/lib/node_modules/typescript/lib"];
      };
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
      theme = "catppuccin_mocha";
    };
  };
}
