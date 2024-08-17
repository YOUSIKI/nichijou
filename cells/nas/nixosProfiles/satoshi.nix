{
  inputs,
  cell,
  config,
  pkgs,
  lib,
  ...
}: let
  mkCifs = cell.lib.mkCifsWithCredentials config.age.secrets.satoshi-credentials.path;
in {
  age.secrets.satoshi-credentials.file = "${inputs.self}/secrets/satoshi-credentials.age";
  fileSystems."/mnt/satoshi/bangumi" = mkCifs "//satoshi.siki.moe/Bangumi";
  fileSystems."/mnt/satoshi/downloads" = mkCifs "//satoshi.siki.moe/Downloads";
  fileSystems."/mnt/satoshi/game" = mkCifs "//satoshi.siki.moe/Game";
  fileSystems."/mnt/satoshi/movie" = mkCifs "//satoshi.siki.moe/Movie";
  fileSystems."/mnt/satoshi/research" = mkCifs "//satoshi.siki.moe/Research";
}
