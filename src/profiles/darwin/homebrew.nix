# Configure homebrew for macOS.
# Note that TUNA mirror is enabled for better experience in China.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  homebrew.enable = true;

  # Upgrade and uninstall homebrew casks automatically.
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.upgrade = true;
  homebrew.onActivation.cleanup = "uninstall";

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

  environment.systemPath =
    if pkgs.system == "aarch64-darwin"
    then [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ]
    else [];
}
