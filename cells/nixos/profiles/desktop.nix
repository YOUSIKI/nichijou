{
  inputs,
  cell,
}: {pkgs, ...}: {
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    _1password-gui
    brave
    clapper
    discord
    dolphin
    dragon
    firefox
    google-chrome
    haruna
    kitty
    motrix
    mpv
    qbittorrent
    qq
    spotify
    steam
    vlc
    vscode
    wezterm
    zotero
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    lxgw-neoxihei
    lxgw-wenkai
    nerdfonts
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-mono
    source-han-sans
    source-han-serif
    wqy_microhei
    wqy_zenhei
  ];
}
