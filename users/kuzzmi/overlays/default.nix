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

  ocenaudio = prev.ocenaudio.overrideAttrs (old: rec {
    version = "3.10.6";
    src = prev.fetchurl {
      url = "https://www.ocenaudio.com/downloads/index.php/ocenaudio_debian9_64.deb?version=${version}";
      sha256 = "1xxv67b80kjbzh3x6h5jcn6plvnfvgigz6z5ra5hkzaxjyxrd34r";
    };
  });
}
