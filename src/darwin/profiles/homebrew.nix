{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  homebrew.enable = true;

  # Upgrade and uninstall homebrew casks automatically.
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.upgrade = true;
  homebrew.onActivation.cleanup = "uninstall";

  # Add taps.
  homebrew.taps = [
    "buo/cask-upgrade"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/cask"
    "homebrew/command-not-found"
    "homebrew/core"
    "homebrew/services"
  ];

  # Add casks.
  homebrew.casks =
    pipe
    ''
      1password
      adobe-creative-cloud
      alt-tab
      bilibili
      cloudflare-warp
      cyberduck
      element
      feishu
      github
      google-chrome
      hiddenbar
      iina
      itsycal
      keepingyouawake
      keka
      logitech-options
      maccy
      macfuse
      microsoft-auto-update
      microsoft-office
      microsoft-remote-desktop
      monitorcontrol
      mos
      motrix
      mounty
      neteasemusic
      notion
      orbstack
      qq
      raycast
      rectangle
      spotify
      surge4
      tailscale
      telegram
      tencent-meeting
      transmission
      visual-studio-code
      warp
      wechat
      zed
      zotero
    ''
    [
      (splitString "\n")
      (filter (s: s != ""))
    ];
}
