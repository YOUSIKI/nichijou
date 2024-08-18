{
  inputs,
  cell,
  config,
  ...
}: let
  mkCifs = cell.lib.mkCifsWithCredentials config.age.secrets.satoshi-credentials.path;
in {
  age.secrets.satoshi-credentials.file = "${inputs.self}/secrets/satoshi-credentials.age";
  fileSystems = {
    "/mnt/satoshi/bangumi" = mkCifs "//satoshi.siki.moe/Bangumi";
    "mnt/satoshi/downloads" = mkCifs "//satoshi.siki.moe/Downloads";
    "/mnt/satoshi/game" = mkCifs "//satoshi.siki.moe/Game";
    "/mnt/satoshi/movie" = mkCifs "//satoshi.siki.moe/Movie";
    "/mnt/satoshi/research" = mkCifs "//satoshi.siki.moe/Research";
  };
}
