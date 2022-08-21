with import <nixpkgs> {
  config.allowUnfree = true;
};
let
  libndi-4 = stdenv.mkDerivation rec {
    name = "libndi-4";
    version = "4.5.1-1";
    src = fetchurl {
      url = "https://github.com/Palakis/obs-ndi/releases/download/4.9.1/libndi4_${version}_amd64.deb";
      sha256 = "sha256-2C5CMcZUPul4yF0RTt2PA4yQK5voWKpsXoR685Ax8ws=";
    };

    nativeBuildInputs = [
      makeWrapper
      autoPatchelfHook
    ];
    buildInputs = [
      avahi
    ];

    unpackPhase = "${dpkg}/bin/dpkg-deb -x ${src} ./";

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/lib
      cp -r usr/bin/* $out/bin
      cp -r usr/lib/* $out/lib
      ls $out/bin
      chmod +x $out/bin/ndi-record
      chmod +x $out/bin/ndi-directory-service
    '';

    dontPatchELF = true;
  };

in buildFHSUserEnv {
  name = libndi-4.name;

  targetPkgs = pkgs: [
    libndi-4
  ];

  # runScript = "iriunwebcam";

  meta = {
    description = "NDI Runtime";
    homepage = "https://ndi.tv/";
    # license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
