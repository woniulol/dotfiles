# Dotfiles — Agent Instructions

## Repository Purpose

This repository manages personal development environments across macOS, Ubuntu, and Arch Linux.

It contains GNU Stow configuration packages and platform-specific installation scripts.

The repository has evolved over time and is not a fully automated, idempotent installer.

## Repository Structure

### GNU Stow Packages

**All application-specific subdirectories are organized as GNU Stow packages**, including:

- `nvim/`, `zsh/`, `ghostty/`, `yazi/`, `tmux/`, `starship/`, etc.
- `aerospace/`, `sketchybar/`, `borders/`, etc. — macOS-specific applications.
- `codex/`, `claude/`, `pi/`, etc. — AI development tools.

Each package follows GNU Stow's directory structure, mirroring its target paths relative to the user's home directory.

**Important:** A directory being Stow-compatible does not mean it is currently deployed on every operating system.

Do not assume all packages should be stowed together.

### Installation Scripts

- `install.sh`: Ubuntu installation and setup workflow.
- `install-arch.sh`: Arch Linux installation and setup workflow.

These scripts document environment setup procedures. Do not assume they are safe to execute repeatedly or without manual intervention.

## Engineering Principles

1. **Inspect before modifying.** Read existing files and understand their purpose.
2. **Preserve cross-platform compatibility.** Changes must not unintentionally break other operating systems.
3. **Prefer minimal changes.** Avoid unnecessary dependencies, abstractions, or restructuring.
4. **Prefer native functionality.** Use existing operating-system and application features before introducing custom solutions.
5. **Preserve existing behavior.** Do not remove working configurations without explicit approval.
6. **Verify assumptions.** Check actual package versions, paths, and application configurations.
7. **Keep changes reversible.** Explain the impact of modifications and provide rollback instructions when appropriate.

## Platform-Specific Guidance

### Arch Linux

**Package management priority:**

1. `pacman` — official Arch Linux repositories; always preferred when the package is available.
2. `yay` — AUR packages, only when the package is unavailable in the official repositories or there is a specific reason to prefer an AUR version.
3. Official upstream releases or source builds — when required or explicitly requested.

Do not recommend `yay` before checking whether the package is available through `pacman`.

Current desktop environment:

- Niri + DMS on Wayland
- Ghostty + Zsh
- NVIDIA + AMD hybrid graphics
- Matugen dynamic theming

On the current Arch Linux installation, only Neovim is confirmed to be managed through GNU Stow.

Other application configurations may exist locally without being managed through Stow.

Additional rules:

- Preserve default Niri behavior whenever practical.
- Do not directly edit DMS-generated configuration files.
- Validate Niri configuration changes with `niri validate`.
- Avoid unnecessary system-level modifications.

### Ubuntu

**Package installation strategy:**

- Prefer `apt` for foundational system packages, libraries, build dependencies, and common utilities available in Ubuntu repositories.
- Higher-level applications and development tools are often installed using official GitHub Releases or compiled from source.
- Some applications, such as Yazi, may be installed through source builds depending on the installation script and available upstream distributions.
- Do not assume every application should be installed through `apt`.
- Check the existing `install.sh` workflow before choosing an installation method.
- Prefer official upstream installation instructions when using GitHub Releases or building from source.

Preserve the existing Ubuntu installation approach unless a change is explicitly requested.

### macOS

- Preserve existing macOS-specific application configurations and setup workflows.
- Do not introduce Linux-specific commands or paths into macOS-only configurations.
- Respect existing installation methods and tooling.

## GNU Stow

- All application configuration subdirectories follow GNU Stow conventions.
- Inspect existing target files and symbolic links before running Stow.
- Never automatically stow every package.
- Stow only packages relevant to the current operating system and intended environment.
- Do not overwrite existing user configurations without explicit approval.
- Preserve existing package layouts unless restructuring is requested.
- Keep generated files, caches, application state, and secrets out of version control.

## Installation Scripts

- Keep platform-specific installation workflows separate.
- Prefer simple, readable commands over complex abstractions.
- Do not assume installation scripts can be executed from beginning to end unattended.
- Clearly distinguish installation-time operations from post-installation configuration.
- Avoid unnecessary `sudo` usage and destructive commands.
- Explain package additions and system-level changes.
- When modifying an installation script, provide the complete revised script.

## Shell and Scripting

- Prefer `${VAR}` syntax for shell variable expansion.
- Quote paths and variables appropriately.
- Distinguish Bash and Zsh syntax explicitly.
- Prefer portable shell constructs when practical.
- Avoid unnecessary external dependencies.

## Safety and Privacy

- Never commit credentials, API tokens, SSH private keys, or other secrets.
- Inspect downloaded scripts before executing them.
- Avoid modifying bootloaders, partitions, filesystems, or system services without explicit approval.
- Review generated files before adding them to Git.

## Communication and Workflow

- Be concise, accurate, and technically precise.
- Diagnose before making changes.
- Work incrementally when troubleshooting.
- Prefer existing configuration and established workflows over new solutions.
- Explain commands when their behavior or side effects are non-obvious.
- Distinguish verified facts from assumptions.
- Do not assume a command succeeded without checking its result.
