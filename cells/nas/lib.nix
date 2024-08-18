{
  inputs,
  cell,
}: {
  mkCifsWithCredentials = credentials: device: {
    inherit device;
    fsType = "cifs";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "noperm"
      "credentials=${credentials}"
    ];
  };
}
