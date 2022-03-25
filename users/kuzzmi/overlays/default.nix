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
      rev    = "460a5661ac20789aa578dc9fb20f3a1ed47e5699";
      sha256 = "10ysvyyj9c0i0rjvb6iz4vckfwfisb5z6kia7sz9ilsjvxy57w7v";
    };
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
