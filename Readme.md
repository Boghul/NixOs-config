# ⚙️ NixOS-config

<div align="center">

![Logo](https://img.shields.io/badge/NixOS-config-5277C3?style=for-the-badge&logo=nixos&logoColor=white) <!-- TODO: Consider adding a project logo representing dotfiles or NixOS -->

[![GitHub stars](https://img.shields.io/github/stars/Boghul/NixOs-config?style=for-the-badge)](https://github.com/Boghul/NixOs-config/stargazers)

[![GitHub forks](https://img.shields.io/github/forks/Boghul/NixOs-config?style=for-the-badge)](https://github.com/Boghul/NixOs-config/network)

[![GitHub issues](https://img.shields.io/github/issues/Boghul/NixOs-config?style=for-the-badge)](https://github.com/Boghul/NixOs-config/issues)

[![GitHub license](https://img.shields.io/badge/license-Unlicensed-blue.svg?style=for-the-badge)](LICENSE)

**A declarative and reproducible NixOS system configuration managed with Nix flakes for a personalized computing experience.**

</div>

## 📖 Overview

This repository houses my personal NixOS configuration, leveraging the power of Nix flakes and Home-Manager to achieve a fully declarative and reproducible system setup. It encapsulates everything from core system services and hardware configurations to user-specific dotfiles, applications, and desktop environment settings.

The goal is to provide a single source of truth for my entire operating system, enabling consistent environments across different machines and ensuring easy migration or disaster recovery. Whether you're a fellow NixOS enthusiast looking for inspiration or planning to adopt a declarative workflow, this configuration demonstrates a robust approach to managing a modern Linux system.

Here is a look at my niri environment: picture & video follows

## ✨ Features

-   🎯 **Declarative System Setup**: Manage the entire NixOS system configuration through Nix language, ensuring reproducibility.
-   📦 **Reproducible Environment with Nix Flakes**: Utilizes Nix flakes for precise dependency locking and consistent system builds.
-   🏡 **Home-Manager Integration**: Declaratively manage user-specific dotfiles, packages, and services (`home.nix`).
-   💻 **Hardware-Specific Optimizations**: Dedicated configuration for system hardware (`hardwareconfiguration.nix`) for optimal performance.
-   🌌 **Niri Wayland Compositor**: Custom configurations for a tailored and efficient Wayland desktop experience.
-   🚀 **Fuzzel Application Launcher**: Personalized settings for a fast and minimalist Wayland application launcher.
-   📊 **Fastfetch System Information**: Configuration for displaying system information with `fastfetch`.
-   🌐 **Flatpak Application Management**: Seamless integration for managing Flatpak applications within NixOS.

## 🛠️ Tech Stack

**Operating System:**

[![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org/)

**Configuration Management:**

[![Nix](https://img.shields.io/badge/Nix-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org/guides/nix-language.html)

[![Nix Flakes](https://img.shields.io/badge/Nix_Flakes-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)

[![Home--Manager](https://img.shields.io/badge/Home--Manager-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://github.com/nix-community/home-manager)

**Key Applications:**

[![Niri](https://img.shields.io/badge/Niri-E33F4F?style=for-the-badge)](https://github.com/sodenn/niri)

[![Fuzzel](https://img.shields.io/badge/Fuzzel-222222?style=for-the-badge)](https://codeberg.org/fuzzel/fuzzel)

[![Fastfetch](https://img.shields.io/badge/Fastfetch-3B5998?style=for-the-badge)](https://github.com/fastfetch-cli/fastfetch)

[![Flatpak](https://img.shields.io/badge/Flatpak-222222?style=for-the-badge&logo=flatpak&logoColor=white)](https://flatpak.org/)

## 📝 To do

[❌] Fix Steam games won't launch

[❌] Fix Heroic games won't launch

[❌] Fix Lutris games won't launch

[❌] Switch from Swaybg to awww

## 🚀 Quick Start

To apply this configuration to your NixOS system, follow these steps. This setup assumes you have NixOS installed and Nix Flakes enabled.

### Prerequisites

-   **NixOS**: An existing NixOS installation.
-   **Nix Flakes Enabled**: Ensure your `/etc/nixos/configuration.nix` includes:
    ```nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    ```
    Then run `sudo nixos-rebuild switch` to apply this change.

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/Boghul/NixOs-config.git
    cd NixOs-config
    ```

2.  **Configure your hostname and username**
    Before applying the configuration, you'll likely need to adjust the `flake.nix` file to match your desired `hostname` and `username`.
    
    _Example `flake.nix` modification (replace `your-hostname` and `your-username`):_
    ```nix
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
    ```
    Alternatively, if the flake supports multiple hosts, you might create a new `hosts/your-hostname/default.nix` or similar structure and reference it in `flake.nix`.

3.  **Apply the NixOS configuration**
    Navigate to the cloned repository and run the `nixos-rebuild` command. Replace `your-hostname` with the name configured in `flake.nix`.
    ```bash
    sudo nixos-rebuild switch --flake .#your-hostname
    ```
    This command will build your entire system and user environment based on the flake, including all system settings and Home-Manager configurations.

4.  **Reboot (if necessary)**
    Some changes (e.g., kernel, bootloader) may require a reboot for full effect.

## 📁 Project Structure

```
NixOs-config/
├── configuration.nix         # Main NixOS system-wide configuration
├── fastfetch/                # Configuration for the fastfetch utility
├── flake.nix                 # Nix Flake definition, entry point for the configuration
├── flatpak.nix               # Nix module for Flatpak application integration
├── fuzzel/                   # Configuration for the fuzzel Wayland application launcher
├── hardwareconfiguration.nix # Hardware-specific system settings
├── home.nix                  # Home-Manager configuration for user-specific settings
└── niri/                     # Configuration for the niri Wayland compositor
```

## ⚙️ Configuration

### Core Configuration Files

-   **`flake.nix`**: Defines the system's inputs (like `nixpkgs`, `home-manager`) and outputs, mapping your local files to a deployable configuration. You might need to adjust the `nixosConfigurations` and `homeConfigurations` sections to match your specific machine's hostname and username.
-   **`configuration.nix`**: This is where system-wide settings are managed, including enabling services, setting up file systems, and installing global packages.
-   **`home.nix`**: This file, managed by Home-Manager, controls your user environment, dotfiles, graphical applications, and user services.

### Modular Configurations

The repository is structured to modularize configurations for specific tools:

-   **`fastfetch/`**: Contains the Nix configuration for `fastfetch`. You can customize its appearance and information displayed here.
-   **`fuzzel/`**: Holds the configuration for the `fuzzel` Wayland launcher, allowing you to define keybindings, appearance, and search behavior.
-   **`niri/`**: Dedicated to configuring the `niri` Wayland compositor, including workspace management, keybindings, and display settings.

To customize any of these, modify the respective `.nix` files within their directories and then rebuild your system using the `nixos-rebuild switch` command.

## 🔧 Management

### Updating the System

To update your NixOS system and Home-Manager configurations based on the latest definitions from your flake inputs:

```bash
cd /path/to/NixOs-config
sudo nixos-rebuild switch --flake .#your-hostname
```
This will fetch updated dependencies (if any, defined in `flake.lock`) and rebuild your system.

### Adding New Packages or Modules

1.  **For system-wide packages/modules**: Edit `configuration.nix`.
2.  **For user-specific packages/dotfiles**: Edit `home.nix` or create new `.nix` files in respective feature directories and import them.
3.  After making changes, apply them with:
    ```bash
    sudo nixos-rebuild switch --flake .#your-hostname
    ```

## 🤝 Contributing

While this is a personal configuration, suggestions for improvements, better Nix practices, or alternative configurations are always welcome.

If you have ideas or find issues, please open an issue or pull request on this repository.

### Development Setup for Contributors

To understand or contribute to this configuration:

1.  **Clone the repository**: `git clone https://github.com/Boghul/NixOs-config.git`
2.  **Explore the `.nix` files**: Analyze `flake.nix`, `configuration.nix`, and `home.nix` to understand the system's structure and declared state.
3.  **Test configurations locally**: If you have a NixOS system, you can test modifications in a temporary or virtual machine environment before applying them to your main system.

## 📄 License

This project is currently **Unlicensed**. See the repository for details.

## 🙏 Acknowledgments

-   **NixOS Project**: For the incredible declarative operating system.
-   **Nix Community**: For countless resources, modules, and inspiration.
-   **Home-Manager Project**: For simplifying user configuration management.
-   **Niri, Fuzzel, Fastfetch Projects**: For providing excellent open-source tools that enhance the system.

## 📞 Support & Contact

-   🐛 Issues: [GitHub Issues](https://github.com/Boghul/NixOs-config/issues)

---

<div align="center">

**⭐ Star this repo if you find it helpful or inspiring!**

Made with ❤️ by [Boghul](https://github.com/Boghul)

</div>

