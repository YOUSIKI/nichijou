{
  lib,
  stdenvNoCC,
  fetchzip,
  source,
  ...
}:
stdenvNoCC.mkDerivation rec {
  inherit (source) pname version;

  src = fetchzip {
    url = "https://github.com/adam7/delugia-code/releases/download/${version}/delugia-complete.zip";
    stripRoot = false;
    hash = "sha256-U4TQNSArtI4adH5O9oem1l3eqXzPjAM4nOd7nxwJAC4=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm644 delugia-complete/*.ttf -t $out/share/fonts/truetype
    runHook postInstall
  '';

  meta = with lib; {
    description = "Cascadia Code + Nerd Fonts";
    homepage = "https://github.com/adam7/delugia-code";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
