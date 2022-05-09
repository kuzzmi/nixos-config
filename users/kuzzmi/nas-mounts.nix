{ lib, config, ... }:
let
  credentials = config.age.secrets.nas.path;
  mounts = [
    { local = "Backups"; remote = "Backups"; }
    # { local = "Containers"; remote = "ContainerData"; }
    { local = "Downloads"; remote = "Download"; }
    { local = "Documents"; remote = "Documents"; }
    { local = "Multimedia"; remote = "Multimedia"; }
    # { local = "Public"; remote = "Public"; }
    { local = "Private"; remote = "Private"; }
  ];
  mount = { local, remote }: {
    fileSystems."/home/kuzzmi/${local}" = {
      device = "//192.168.88.251/${remote}";
      fsType = "cifs";
      options = [ "credentials=${credentials}" "x-systemd.automount" "noauto" "uid=kuzzmi"];
    };
  };
in {
  imports = map mount mounts;
}
