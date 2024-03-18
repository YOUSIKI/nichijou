# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  catppuccin-bat = {
    pname = "catppuccin-bat";
    version = "b19bea35a85a32294ac4732cad5b0dc6495bed32";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "b19bea35a85a32294ac4732cad5b0dc6495bed32";
      fetchSubmodules = false;
      sha256 = "sha256-POoW2sEM6jiymbb+W/9DKIjDM1Buu1HAmrNP0yC2JPg=";
    };
    date = "2024-03-14";
  };
  catppuccin-bottom = {
    pname = "catppuccin-bottom";
    version = "c0efe9025f62f618a407999d89b04a231ba99c92";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "c0efe9025f62f618a407999d89b04a231ba99c92";
      fetchSubmodules = false;
      sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
    };
    date = "2022-12-30";
  };
  catppuccin-btop = {
    pname = "catppuccin-btop";
    version = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
      fetchSubmodules = false;
      sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
    };
    date = "2023-10-07";
  };
  catppuccin-gitui = {
    pname = "catppuccin-gitui";
    version = "39978362b2c88b636cacd55b65d2f05c45a47eb9";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "gitui";
      rev = "39978362b2c88b636cacd55b65d2f05c45a47eb9";
      fetchSubmodules = false;
      sha256 = "sha256-kWaHQ1+uoasT8zXxOxkur+QgZu1wLsOOrP/TL+6cfII=";
    };
    date = "2023-11-13";
  };
  catppuccin-starship = {
    pname = "catppuccin-starship";
    version = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      fetchSubmodules = false;
      sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    };
    date = "2023-07-13";
  };
  clash-meta = {
    pname = "clash-meta";
    version = "v1.18.1";
    src = fetchFromGitHub {
      owner = "MetaCubeX";
      repo = "mihomo";
      rev = "v1.18.1";
      fetchSubmodules = false;
      sha256 = "sha256-ezOkDrpytZQdc+Txe4eUyuWY6oipn9jIrmu7aO8lNlQ=";
    };
  };
  lporg = {
    pname = "lporg";
    version = "v20.4.31";
    src = fetchFromGitHub {
      owner = "blacktop";
      repo = "lporg";
      rev = "v20.4.31";
      fetchSubmodules = false;
      sha256 = "sha256-A/OE67qAn9RHSCveiRwG5lPYNTMdrbUWVfQOP3XjkdU=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "563ef2645ba995c45ba109dde60f7ac64a7443b9";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "563ef2645ba995c45ba109dde60f7ac64a7443b9";
      fetchSubmodules = false;
      sha256 = "sha256-1lxBjVIIIDlz6JGZrRf2ZjCAiEQN9Ru8MSX12tDoGo8=";
    };
    date = "2024-03-18";
  };
}