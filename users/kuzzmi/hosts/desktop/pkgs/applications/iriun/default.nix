with import <nixpkgs> {
  config.allowUnfree = true;
};
let
  iriun = stdenv.mkDerivation rec {
    name = "iriun";
    version = "2.6";
    src = fetchurl {
      url = "https://iriun.gitlab.io/iriunwebcam-${version}.deb";
      sha256 = "sha256-5nf/Ai4g1IcdP67lJ5n7fDegnVQ/OxO3z+vfHYbniEY=";
    };

    nativeBuildInputs = [
      makeWrapper
      autoPatchelfHook
    ];
    buildInputs = [
      avahi
      alsa-lib
      v4l-utils
      libsForQt5.qt5.wrapQtAppsHook
      libsForQt5.qt5.qtbase
    ];

    unpackPhase = "${dpkg}/bin/dpkg-deb -x ${src} ./";

    installPhase = ''
      mkdir -p $out/bin
      cp -r usr/local/* $out/
      ls $out/bin
      chmod +x $out/bin/iriunwebcam
    '';

    dontPatchELF = true;
  };

in buildFHSUserEnv {
  name = iriun.name;

  targetPkgs = pkgs: [
    iriun
  ];

  runScript = "iriunwebcam";

  meta = {
    description = "Use your phone's camera as a wireless webcam in your PC or Mac.";
    homepage = "https://iriun.com/";
    # license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
