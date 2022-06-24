final: prev:

{
  # mailspring = prev.mailspring.overrideAttrs (old: {
  #   version = "1.8.0-libre";
  #   src = builtins.fetchTarball {
  #     url = "https://github.com/notpushkin/Mailspring-Libre/releases/download/1.8.0-libre/mailspring-1.8.0-libre-amd64.deb";
  #     sha256 = "0pcy657xh3ms78h06hlx657r1sc4mq11jin9q6z32nsqsc1fp146";
  #   };
  # });

  ledger = prev.ledger.overrideAttrs (old: rec {
    src = prev.fetchFromGitHub {
      owner  = "ledger";
      repo   = "ledger";
      rev    = "61ffed6ece4857fe5e708f5c3bd6d7e6d2b2b13b";
      sha256 = "sha256-bOKoqb1L+T0yGf4AK5rHyojaUyelho9SSrGIOTjAgt8=";
    };
  });

  youtube-dl = prev.youtube-dl.overrideAttrs (old: rec {
    patches = [
      (prev.fetchpatch {
        name = "fix-youtube-dl-speed.patch";
        url = "https://github.com/ytdl-org/youtube-dl/compare/57044eacebc6f2f3cd83c345e1b6e659a22e4773...1e677567cd083d43f55daef0cc74e5fa24575ae3.diff";
        sha256 = "11s0j3w60r75xx20p0x2j3yc4d3yvz99r0572si8b5qd93lqs4pr";
      })
      (prev.fetchpatch {
        name = "fix-youtube-player.patch";
        url = "https://github.com/ytdl-org/youtube-dl/compare/1e677567cd083d43f55daef0cc74e5fa24575ae3...a0068bd6bec16008bda7a39caecccbf84881c603.diff";
        sha256 = "R7yXAH7PzDTWAKm4GG5JZrIkAb6lrRjF968EIeATc2g=";
      })
    ];
  });

  # ocenaudio = prev.ocenaudio.overrideAttrs (old: rec {
  #   version = "3.10.6";
  #   src = prev.fetchurl {
  #     url = "https://www.ocenaudio.com/downloads/index.php/ocenaudio_debian9_64.deb?version=${version}";
  #     sha256 = "1xxv67b80kjbzh3x6h5jcn6plvnfvgigz6z5ra5hkzaxjyxrd34r";
  #   };
  # });

  # lightworks_2022 = prev.lightworks.overrideAttrs (old: rec {
  #   version = "2022.1.1";
  #   rev = "132185";
  #   src = prev.fetchurl {
  #     url = "https://cdn.lwks.com/releases/${version}/lightworks_${version}_r${rev}.deb";
  #     sha256 = "sha256-uZn9PRPlnF4Ov2jNY1KzMvi/OMPdGomkdIpA/u3JLvA=";
  #   };
  # });

  ethminer = prev.ethminer.overrideAttrs (old: rec {
    src =
      prev.fetchFromGitHub {
        owner = "ethereum-mining";
        repo = "ethminer";
        rev = "master";
        sha256 = "1kyff3vx2r4hjpqah9qk99z6dwz7nsnbnhhl6a76mdhjmgp1q646";
        fetchSubmodules = true;
      };

    buildInputs = [
      prev.cli11
      prev.boost
      prev.opencl-headers
      prev.mesa
      prev.ethash
      prev.opencl-info
      prev.ocl-icd
      prev.openssl
      prev.jsoncpp
      prev.cudatoolkit_11
    ];

    cmakeFlags = [
      "-DHUNTER_ENABLED=OFF"
      "-DETHASHCUDA=ON"
      "-DAPICORE=ON"
      "-DETHDBUS=OFF"
      "-DCMAKE_BUILD_TYPE=Release"
      "-DCUDA_PROPAGATE_HOST_FLAGS=off"
    ];
  });
}
