{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.cells.common.darwinProfiles.nix
    inputs.cells.common.darwinProfiles.packages
    inputs.cells.common.darwinProfiles.home-manager
  ];

  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;
    # Upgrade and uninstall homebrew casks automatically.
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
  };

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
  ];

  environment.systemPackages = [
    inputs.cells.lporg.packages.lporg
  ];

  system.stateVersion = 4;
}
