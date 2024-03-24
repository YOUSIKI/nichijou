<!-- nichijou: nix configurations for daily life -->

<h1 align="center"><i>nichijou</i> &ensp;|&ensp; 日常 &ensp;|&ensp; にちじょう </h1>
<p align="center" style="font-size:large;"><i>nix configurations for daily life</i></p>

<p align="center" style="font-size:large;">
🚧 STILL UNDER CONSTRUCTION 🚧
</p>

<p align="center">
<!-- nixos-unstable -->
<a href="https://github.com/nixos/nixpkgs"><img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"></a>
<!-- build -->
<a href="https://github.com/YOUSIKI/nichijou/actions/workflows/build-devshell.yaml"><img src="https://github.com/YOUSIKI/nichijou/actions/workflows/build-devshell.yaml/badge.svg"></a>
<a href="https://github.com/YOUSIKI/nichijou/actions/workflows/build-hakase.yaml"><img src="https://github.com/YOUSIKI/nichijou/actions/workflows/build-hakase.yaml/badge.svg"></a>
<!-- flakehub -->
<a href="https://flakehub.com/flake/YOUSIKI/nichijou"><img src="https://img.shields.io/endpoint?url=https://flakehub.com/f/YOUSIKI/nichijou/badge"></a>
</p>

<p align="center">
  <a href="https://nichijou.fandom.com/wiki/Sakamoto"><img src="static/images/sakamoto.gif" width="500px" alt="Sakamoto"/></a>
</p>

## 🧭 Usage

Add nichijou to your `flake.nix`:

```nix
{
  inputs = {
    nichijou.url = "github:yousiki/nichijou";
    nichijou.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nichijou }: {
    # Use in your outputs
  };
}
```

## 💾 Modules

### Multi-device bcachefs module

```nix
imports = [
  nichijou.nixosModules.bcachefs
];

bcachefs.fileSystems."/data" = {
  devices = ["/dev/sda1" "/dev/sdb1" "/dev/sdc1"];
  options = ["noatime"];
};
```

## 🧱 Structure

<details>

<summary>Snapshot 20240321</summary>

```text
 nichijou
├──  cells
│  ├──  common
│  │  ├──  commonProfiles.nix
│  │  ├──  configs.nix
│  │  ├──  devshells.nix
│  │  ├──  lib.nix
│  │  └──  profiles
│  │     └──  core.nix
│  ├── 󱂵 home
│  │  ├──  homeProfiles.nix
│  │  └──  profiles
│  │     ├──  base.nix
│  │     ├──  catppuccin.nix
│  │     ├──  core.nix
│  │     ├──  languages.nix
│  │     ├──  shell.nix
│  │     └──  ssh.nix
│  └──  nixos
│     ├──  hosts
│     │  └──  hakase
│     │     ├──  configuration.nix
│     │     ├──  default.nix
│     │     └──  hardware-configuration.nix
│     ├──  modules
│     │  └──  bcachefs.nix
│     ├──  nixosConfigurations.nix
│     ├──  nixosModules.nix
│     ├──  nixosProfiles.nix
│     └──  profiles
│        ├──  core.nix
│        ├──  desktop.nix
│        ├──  nvidia.nix
│        └──  server.nix
├──  flake.lock
├──  flake.nix
├──  garnix.yaml
├──  LICENSE
├──  nvfetcher
│  ├──  generated.json
│  └──  generated.nix
├──  nvfetcher.toml
└──  README.md
```

</details>

## ⛰️ Giants

This repository stands on the shoulders of giants:

- Awesome dotfiles
  - [truelecter/hive](https://github.com/truelecter/hive)
  - [GTrunSec/hive](https://github.com/GTrunSec/hive)
  - [Ruixi-rebirth/flakes](https://github.com/Ruixi-rebirth/flakes)
  - [rxyhn/yuki](https://github.com/rxyhn/yuki)
  - [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
  - [linuxmobile/hyprland-dots](https://github.com/linuxmobile/hyprland-dots)
  - and more ...
- Awesome tools
  - [divnix/hive](https://github.com/divnix/hive)
  - [divnix/std](https://github.com/divnix/std)
  - [nix-community/haumea](https://github.com/nix-community/haumea)
  - [numtide/treefmt-nix](https://github.com/numtide/treefmt-nix)
  - [hercules-ci/flake-parts](https://github.com/hercules-ci/flake-parts)
  - and more ...
