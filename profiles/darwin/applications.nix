# Manage applications using Homebrew
{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
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
      applite
      arc
      bilibili
      clashx
      cloudflare-warp
      cursor
      cyberduck
      element
      feishu
      github
      google-chrome
      hiddenbar
      iina
      itsycal
      jetbrains-toolbox
      keepingyouawake
      keka
      kitty
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
      sioyek
      spotify
      surge4
      tailscale
      telegram
      tencent-meeting
      transmission
      visual-studio-code
      warp
      wechat
      wezterm
      zed
      zotero
    ''
    [
      (splitString "\n")
      (filter (s: s != ""))
    ];

  environment.systemPath =
    if pkgs.system == "aarch64-darwin"
    then [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ]
    else [];
}
