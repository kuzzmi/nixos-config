let
  kuzzmi = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3dc8URao5mjyeiQvfcgLjii6bIJB+lSzHN5effXKsmIykZrlkroEUVN6+ajUO5HDjL0VO+sob0L1fKYSYDARee3Pqt/h/ixzVAaKb9XTJrJ7AHkgGgVXOob7GTc6Cj4Gs5FxREgpQ1RohWSENsWVq4EkgkxAEoipVCxgKbCMhRDvRF1HRZGPtCKS/NqYFJlq6uKyLdVyG4F0smYSoeDDbNSpdT3xZHIifc8Hd3dd4CHH99L0w3X0dRcRCZoxQn249q5CgT2uaswiRg2EYzekhqV4t6vy+ztg/Su3gJxGOA7LfvRo+vQOkLblW9k/MMk0/TJoia5y0q5H3L6pUV9B9VeaYzZDCCJLokuHF2cE9ICbZ6SU0qlV/16BExunyv98pRybq/d14ezftPo0c41kP+1/doWNY07gzX+M4eVmwP0sMQdJpz38/7tR6fUAZpMQI5fVP3sj+0d+o3ynf5S0jScqaGC6DEFbLo+pwGfS3jmnbtlAsReItRR+izPhPGQMxw8XMA6uxgxWDy/633h3XoXPXvtUVc8+NJOquB0AWiFUW3vNm36do3hn0npzlQXmb/jCc0xTlpVbYKaiPVQIUaLbrI9XnK6BRbdIiiLJnYc8J/SgbI2im3hUn91z8MYPTr/Grr1PORqPp/Q5k4yuoz5P3UFz3qDd9zRpfpEmYaw== igor@kuzzmi.com";
  # kuzzmi = lib.strings.fileContents /nix/persist/home/kuzzmi/.ssh/id_rsa.pub;
in
{
  "/etc/nixos/users/kuzzmi/secrets/nas.age".publicKeys = [ kuzzmi ];
  "/etc/nixos/users/kuzzmi/secrets/passwd.age".publicKeys = [ kuzzmi ];
}
