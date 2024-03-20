{
  inputs,
  cell,
}: {
  pkgs,
  lib,
  config,
  ...
}: let
  l = builtins // lib;

  bcachefsFileSystem = {
    name,
    config,
    ...
  }: {
    options = {
      devices = l.mkOption {
        type = l.types.listOf l.types.path;
        description = lib.mdDoc "The devices to use for the filesystem.";
      };

      options = l.mkOption {
        type = l.types.listOf l.types.str;
        default = [];
        description = lib.mdDoc "Additional options to pass to `mount`.";
      };
    };
  };

  pathToString = path: l.replaceStrings ["/"] ["-"] (l.toString path);

  mkUnit = mountPoint: mountOptions: let
    inherit (mountOptions) devices options;
    deviceTargets = l.pipe devices [
      (l.map pathToString)
      (l.map (l.removePrefix "-"))
      (l.map (device: "${device}.device"))
    ];
    concatDevices = l.concatStringsSep ":" (l.map l.toString devices);
    concatOptions = l.concatStringsSep "," options;
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
    bcachefs.fileSystems = l.mkOption {
      default = {};
      example = l.literalExpression ''
        {
          "/data" = {
            device = [ "/dev/sda1" "/dev/sdb1" ];
            options = [ "noatime" ];
          };
        }
      '';
      type = l.types.attrsOf (l.types.submodule [bcachefsFileSystem]);
    };
  };

  config = {
    systemd = {
      packages = with pkgs; [bcachefs-tools];
      services = l.mapAttrs' (name: value:
        l.nameValuePair
        "mount-bcachefs-volume-${pathToString name}"
        (mkUnit name value))
      config.bcachefs.fileSystems;
    };
  };
}
