{ lib, config, ... }:
let
  credentials = config.age.secrets.nas.path;
  mounts = [
    # { local = "Backups"; remote = "Backups"; }
    # { local = "Downloads"; remote = "Download"; }
    # { local = "Documents"; remote = "Documents"; }
    { local = "Multimedia"; remote = "Multimedia"; }
    # { local = "Private"; remote = "Private"; }
    # { local = "Public"; remote = "Public"; }
    # { local = "Containers"; remote = "ContainerData"; }
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
