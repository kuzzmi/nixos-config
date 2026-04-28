# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal Nix configuration for NixOS, nix-darwin, and Home Manager.

- `configuration.nix` is the Linux/NixOS entry point.
- `darwin-configuration.nix` is the macOS/nix-darwin entry point.
- `common-configuration.nix` holds shared system settings and imports `users/kuzzmi/default.nix`.
- `users/kuzzmi/default.nix` selects the platform host module and defines shared Home Manager imports.
- `users/kuzzmi/hosts/desktop/` contains Linux desktop-specific modules, packages, services, and window-manager programs.
- `users/kuzzmi/hosts/macbook/` contains macOS-specific settings.
- `users/kuzzmi/programs/` contains reusable Home Manager program modules such as `nvim`, `zsh`, `tmux`, `kitty`, and `git`.
- `users/kuzzmi/secrets/` contains agenix-managed encrypted secrets. Do not commit decrypted secret material.

## Build, Test, and Development Commands

- `nix-instantiate --parse configuration.nix`: check NixOS syntax without building.
- `nix-instantiate --parse darwin-configuration.nix`: check nix-darwin syntax without building.
- `nixpkgs-fmt .`: format Nix files if `nixpkgs-fmt` is available.
- `sudo nixos-rebuild test -I nixos-config=$PWD/configuration.nix`: test the Linux system configuration without making it the boot default.
- `darwin-rebuild check -I darwin-config=$PWD/darwin-configuration.nix`: validate the macOS configuration.
- `darwin-rebuild switch -I darwin-config=$PWD/darwin-configuration.nix`: apply macOS changes after review.
- `SUDO_ASKPASS=$PWD/scripts/macos-sudo-askpass.sh sudo -A darwin-rebuild check --show-trace --print-build-logs -I darwin-config=$PWD/darwin-configuration.nix`: validate macOS with a local password dialog and useful failure logs.
- `SUDO_ASKPASS=$PWD/scripts/macos-sudo-askpass.sh sudo -A darwin-rebuild switch --show-trace --print-build-logs -I darwin-config=$PWD/darwin-configuration.nix`: apply macOS changes with a local password dialog after validation.

## Coding Style & Naming Conventions

Use two-space indentation in Nix files, keep attribute sets explicit, and include semicolons on assignments. Prefer small modules under the nearest relevant directory, for example `users/kuzzmi/programs/<tool>/default.nix` for shared Home Manager programs or `users/kuzzmi/hosts/desktop/services/<name>/default.nix` for desktop-only services. Keep host-specific choices out of shared modules unless both platforms need them.

## Testing Guidelines

There is no standalone test suite. Validate changes by parsing the touched entry point and running the matching rebuild check/test command for the target platform. For package overlays or custom packages, evaluate the package before switching when practical, for example `nix-build -E 'with import <nixpkgs> {}; callPackage ./path/to/pkg.nix {}'`.

## Commit & Pull Request Guidelines

Git history uses short, informal subjects such as `upd`, `fix`, and `upd zsh`. Keep commits focused and use concise imperative subjects, preferably with the affected area named, for example `upd nvim` or `fix darwin fonts`. Pull requests should describe the target host, summarize behavior changes, mention any rebuild command run, and call out secret, firewall, or persistence changes explicitly.

## Agent-Specific Instructions

Do not rewrite unrelated personal configuration. Preserve encrypted `.age` files and avoid exposing secrets, keys, hostnames, or private paths beyond what is already committed. Prefer validation commands before any rebuild or switch command.

On macOS, if `darwin-rebuild` or another required command needs `sudo`, do not ask for or accept a password in chat. After the user agrees to a local dialog, run `sudo -A` with `SUDO_ASKPASS=$PWD/scripts/macos-sudo-askpass.sh` so macOS prompts for the password directly. Use `--show-trace --print-build-logs` for nix-darwin commands when tracing failures.
