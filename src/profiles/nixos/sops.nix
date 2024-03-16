# Configure sops-nix for NixOS.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    globals.inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    age
    gnupg
    sops
    ssh-to-age
    ssh-to-pgp
  ];

  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  # sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
  # sops.defaultSopsFile = globals.root + /secrets/secrets.yaml;
  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;
  # This is the actual specification of the secrets.
  sops.secrets.nas-credentials = {
    sopsFile = globals.root + /secrets/nas-credentials.env;
    format = "dotenv";
  };
}
