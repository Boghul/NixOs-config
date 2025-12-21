⚙️ NixOS-config

Logo

GitHub stars

GitHub forks

GitHub issues

GitHub license

A declarative and reproducible NixOS system configuration managed with Nix flakes for a personalized computing experience.
📖 Overview

This repository houses my personal NixOS configuration, leveraging the power of Nix flakes and Home-Manager to achieve a fully declarative and reproducible system setup. It encapsulates everything from core system services and hardware configurations to user-specific dotfiles, applications, and desktop environment settings.

The goal is to provide a single source of truth for my entire operating system, enabling consistent environments across different machines and ensuring easy migration or disaster recovery. Whether you’re a fellow NixOS enthusiast looking for inspiration or planning to adopt a declarative workflow, this configuration demonstrates a robust approach to managing a modern Linux system.

Here is a look at my niri environment: picture & video follows

✨ Features

    🎯 Declarative System Setup: Manage the entire NixOS system configuration through Nix language, ensuring reproducibility.
    📦 Reproducible Environment with Nix Flakes: Utilizes Nix flakes for precise dependency locking and consistent system builds.
    🏡 Home-Manager Integration: Declaratively manage user-specific dotfiles, packages, and services (home.nix).
    💻 Hardware-Specific Optimizations: Dedicated configuration for system hardware (hardwareconfiguration.nix) for optimal performance.
    🌌 Niri Wayland Compositor: Custom configurations for a tailored and efficient Wayland desktop experience.
    🚀 Fuzzel Application Launcher: Personalized settings for a fast and minimalist Wayland application launcher.
    📊 Fastfetch System Information: Configuration for displaying system information with fastfetch.
    🌐 Flatpak Application Management: Seamless integration for managing Flatpak applications within NixOS.

🛠️ Tech Stack

Operating System:

NixOS

Configuration Management:

Nix

Nix Flakes

Home--Manager

Key Applications:

Niri

Fuzzel

Fastfetch

Flatpak
📝 To do

[❌] Fix Steam games won’t launch
[❌] Fix Heroic games won’t launch
[❌] Fix Lutris games won’t launch
[❌] Switch from Swaybg to awww
🚀 Quick Start

To apply this configuration to your NixOS system, follow these steps. This setup assumes you have NixOS installed and Nix Flakes enabled.
Prerequisites

    NixOS: An existing NixOS installation.
    Nix Flakes Enabled: Ensure your /etc/nixos/configuration.nix includes:

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    Then run sudo nixos-rebuild switch to apply this change.

Installation

    Clone the repository

    git clone https://github.com/Boghul/NixOs-config.git
    cd NixOs-config

    Configure your hostname and username
    Before applying the configuration, you’ll likely need to adjust the flake.nix file to match your desired hostname and username.

    Example flake.nix modification (replace your-hostname and your-username):

    # flake.nix (example snippet)
    outputs = { self, nixpkgs, home-manager, ... }: {
      nixosConfigurations = {
        "your-hostname" = nixpkgs.lib.nixosSystem {
          # ...
          modules = [
            ./configuration.nix
            ./hardwareconfiguration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."your-username" = import ./home.nix;
            }
          ];
        };
      };
      # ...
    };

    Alternatively, if the flake supports multiple hosts, you might create a new hosts/your-hostname/default.nix or similar structure and reference it in flake.nix.

    Apply the NixOS configuration
    Navigate to the cloned repository and run the nixos-rebuild command. Replace your-hostname with the name configured in flake.nix.

    sudo nixos-rebuild switch --flake .#your-hostname

    This command will build your entire system and user environment based on the flake, including all system settings and Home-Manager configurations.

    Reboot (if necessary)
    Some changes (e.g., kernel, bootloader) may require a reboot for full effect.

📁 Project Structure

NixOs-config/
├── configuration.nix         # Main NixOS system-wide configuration
├── fastfetch/                # Configuration for the fastfetch utility
├── flake.nix                 # Nix Flake definition, entry point for the configuration
├── flatpak.nix               # Nix module for Flatpak application integration
├── fuzzel/                   # Configuration for the fuzzel Wayland application launcher
├── hardwareconfiguration.nix # Hardware-specific system settings
├── home.nix                  # Home-Manager configuration for user-specific settings
└── niri/                     # Configuration for the niri Wayland compositor

⚙️ Configuration
Core Configuration Files

    flake.nix: Defines the system’s inputs (like nixpkgs, home-manager) and outputs, mapping your local files to a deployable configuration. You might need to adjust the nixosConfigurations and homeConfigurations sections to match your specific machine’s hostname and username.
    configuration.nix: This is where system-wide settings are managed, including enabling services, setting up file systems, and installing global packages.
    home.nix: This file, managed by Home-Manager, controls your user environment, dotfiles, graphical applications, and user services.

Modular Configurations

The repository is structured to modularize configurations for specific tools:

    fastfetch/: Contains the Nix configuration for fastfetch. You can customize its appearance and information displayed here.
    fuzzel/: Holds the configuration for the fuzzel Wayland launcher, allowing you to define keybindings, appearance, and search behavior.
    niri/: Dedicated to configuring the niri Wayland compositor, including workspace management, keybindings, and display settings.

To customize any of these, modify the respective .nix files within their directories and then rebuild your system using the nixos-rebuild switch command.
🔧 Management
Updating the System

To update your NixOS system and Home-Manager configurations based on the latest definitions from your flake inputs:

cd /path/to/NixOs-config
sudo nixos-rebuild switch --flake .#your-hostname

This will fetch updated dependencies (if any, defined in flake.lock) and rebuild your system.
Adding New Packages or Modules

    For system-wide packages/modules: Edit configuration.nix.
    For user-specific packages/dotfiles: Edit home.nix or create new .nix files in respective feature directories and import them.
    After making changes, apply them with:

    sudo nixos-rebuild switch --flake .#your-hostname

🤝 Contributing

While this is a personal configuration, suggestions for improvements, better Nix practices, or alternative configurations are always welcome.

If you have ideas or find issues, please open an issue or pull request on this repository.
Development Setup for Contributors

To understand or contribute to this configuration:

    Clone the repository: git clone https://github.com/Boghul/NixOs-config.git
    Explore the .nix files: Analyze flake.nix, configuration.nix, and home.nix to understand the system’s structure and declared state.
    Test configurations locally: If you have a NixOS system, you can test modifications in a temporary or virtual machine environment before applying them to your main system.

📄 License

This project is currently Unlicensed. See the repository for details.
🙏 Acknowledgments

    NixOS Project: For the incredible declarative operating system.
    Nix Community: For countless resources, modules, and inspiration.
    Home-Manager Project: For simplifying user configuration management.
    Niri, Fuzzel, Fastfetch Projects: For providing excellent open-source tools that enhance the system.

📞 Support & Contact

    🐛 Issues: GitHub Issues
