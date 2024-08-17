# NixOS module to mount bcachefs volumes with multiple devices
{
  config,
  pkgs,
  lib,
  ...
}: let
  bcachefsVolume = {
    name,
    config,
    ...
  }: {
    options = {
      devices = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        description = lib.mdDoc "The devices to use for the filesystem.";
      };

      options = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = lib.mdDoc "Additional options to pass to `mount`.";
      };
    };
  };

  pathToString = path: lib.replaceStrings ["/"] ["-"] (builtins.toString path);

  mkUnit = mountPoint: mountOptions: let
    inherit (mountOptions) devices options;
    deviceTargets = lib.pipe devices [
      (builtins.map pathToString)
      (builtins.map (lib.removePrefix "-"))
      (builtins.map (device: "${device}.device"))
    ];
    concatDevices = lib.concatStringsSep ":" (builtins.map builtins.toString devices);
    concatOptions = lib.concatStringsSep "," options;
  in {
    description = "Mount bcachefs volume ${mountPoint}";
    bindsTo = deviceTargets;
    after = deviceTargets ++ ["local-fs-pre.target"];
    before = ["umount.target" "local-fs.target"];
    conflicts = ["umount.target"];
    wantedBy = ["local-fs.target"];
    unitConfig = {
      RequiresMountsFor = mountPoint;
      DefaultDependencies = false;
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.util-linux}/bin/mount -t bcachefs -o ${concatOptions} ${concatDevices} ${mountPoint}";
      ExecStop = "${pkgs.util-linux}/umount ${mountPoint}";
    };
  };
in {
  options = {
    bcachefs = lib.mkOption {
      default = {};
      example = lib.literalExpression ''
        {
          "/data" = {
            device = [ "/dev/sda1" "/dev/sdb1" ];
            options = [ "noatime" ];
          };
        }
      '';
      type = lib.types.attrsOf (lib.types.submodule [bcachefsVolume]);
    };
  };

  config = {
    systemd = {
      packages = with pkgs; [bcachefs-tools];
      services = lib.mapAttrs' (name: value:
        lib.nameValuePair
        "mount-bcachefs-volume-${pathToString name}"
        (mkUnit name value))
      config.bcachefs;
    };
  };
}
