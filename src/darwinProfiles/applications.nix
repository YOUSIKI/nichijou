# Install macOS applications with homebrew.
{globals, ...}: {
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
  # homebrew.onActivation.cleanup = "uninstall";

  # Set environment variables.
  environment.variables = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  # Add taps.
  homebrew.taps = [
    "buo/cask-upgrade"
    {
      name = "homebrew/cask-fonts";
      clone_target = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git";
    }
    {
      name = "homebrew/cask-versions";
      clone_target = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-versions.git";
    }
    {
      name = "homebrew/command-not-found";
      clone_target = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-command-not-found.git";
    }
    {
      name = "homebrew/services";
      clone_target = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-services.git";
    }
  ];

  # Add casks.
  homebrew.casks = [
    "1password"
    "adobe-creative-cloud"
    "adrive"
    "alt-tab"
    "altserver"
    "applite"
    "arc"
    "baidunetdisk"
    "balenaetcher"
    "bilibili"
    "brave-browser"
    "cloudflare-warp"
    "cyberduck"
    "discord"
    "element"
    "feishu"
    "firefox"
    "font-caskaydia-cove-nerd-font"
    "font-fira-code-nerd-font"
    "font-jetbrains-mono-nerd-font"
    "font-lxgw-bright"
    "font-lxgw-wenkai"
    "font-monaspace"
    "github"
    "google-chrome"
    "google-drive"
    "handbrake"
    "hiddenbar"
    "iina"
    "itsycal"
    "jetbrains-toolbox"
    "keepingyouawake"
    "keka"
    "kitty"
    "logitech-options"
    "maccy"
    "microsoft-auto-update"
    "microsoft-office"
    "microsoft-remote-desktop"
    "miniconda"
    "monitorcontrol"
    "mos"
    "motrix"
    "mounty"
    "neovide"
    "neteasemusic"
    "obs"
    "obsidian"
    "onyx"
    "orbstack"
    "plex"
    "poe"
    "qfinder-pro"
    "qq"
    "qsync-client"
    "qudedup-extract-tool"
    "raycast"
    "rectangle"
    "sioyek"
    "spotify"
    "squirrel"
    "stats"
    "steam"
    "tailscale"
    "tencent-meeting"
    "transmission"
    "visual-studio-code"
    "warp"
    "wechat"
    "wezterm"
    "xpra"
    "xquartz"
    "zed"
    "zotero"
  ];

  environment.systemPath =
    if pkgs.system == "aarch64-darwin"
    then [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ]
    else [];
}
