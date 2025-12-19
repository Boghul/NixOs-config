#not finshed yet, still in work!

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan.
      #./fuzzel.nix
     # ./steam.nix
     #./flatpak.nix
    #./vicinae.nix
    ];
  # Bootloader.
  boot = {
   loader = {
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = true;
  systemd-boot.configurationLimit = 10; # Show up to 10 generations
  };
  # Use latest kernel.
  kernelPackages = pkgs.linuxPackages_latest;
  kernelParams = [
      "amdgpu.dc=1"
      "amd_iommu=on"
      "acpi_osi=Linux"
    ];
    kernelModules = [
      "kvm-amd"
      "amdgpu"
      "tpm_cbr"
    ];
    extraModprobeConfig = "options amdgpu ppfeaturemask=0xffffffff\n\n";
    bootspec = {
      enableValidation = true;
    };
  }; 
    networking.hostName = "nixos"; # Define your hostname.
    #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

    # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      atkinson-hyperlegible
      geist-font
      nerd-fonts.fira-code
      nerd-fonts.geist-mono
      source-code-pro
    ];
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "deadacute";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Hardware Configuration #Steam #Controller #OpenGL #fwupd #Bluetooth
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd # OpenCL
        libva # VA-API
      ];
      extraPackages32 = [ ];
    };
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      overdrive.enable = true;
    };
    steam-hardware.enable = true;
    #xone.enable = true;
    #xpadneo.enable = true;
    cpu.amd.updateMicrocode = true;

bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      # Shows battery charge of connected devices on supported
      # Bluetooth adapters. Defaults to 'false'.
      Experimental = true;
      # When enabled other devices can connect faster to us, however
      # the tradeoff is increased power consumption. Defaults to
      # 'false'.
      FastConnectable = true;
    };
    Policy = {
      # Enable all controllers when they are found. This includes
      # adapters present on start as well as adapters that are plugged
      # in later on. Defaults to 'true'.
      AutoEnable = true;
     };
   };
 };
};
hardware.enableAllFirmware = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xenomorph = {
    isNormalUser = true;
    description = "Thorsten ";
    extraGroups = [ "networkmanager"
		    "wheel"
	  	    "audio"
		    "gamemode"
       		    "cpugovctl"
       		    "sysctlgroup"
       		    "libvirtd"
       		    "kvm"
       		    "input"
       		    "plugdev"
       		    "tss"
       		    "immich"
                  ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
  ];
};



  # Install openrgb
  services.hardware.openrgb.enable = true;

  # Gui BluetoothManager
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  #$ nix search wget
  environment.systemPackages = with pkgs; [
  # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  # pkgs.vimPlugins.clever-f-vim
  
  # Terminal
  wget
  fastfetch
  kitty
  ninja
  cmake
  gnumake
  curl
  git
  tree

  # zsh
  zsh
  oh-my-zsh
  zsh-autocomplete
  zsh-autosuggestions
  zsh-fast-syntax-highlighting
  zsh-syntax-highlighting

  # Multimedia
  musikcube
  mpv
  lutris
  pkgs.heroic
  #pkgs.heroic-unwrapped
  legendary-gl # epic launcher
  #pkgs.steam
  #steam
  steam-run
  pkgs.protonplus
  pkgs.pavucontrol

  # Communication
  #pkgs.zapzap
  wasistlos
  signal-desktop
  pkgs.protonmail-desktop
  pkgs.protonmail-bridge

  # programs
  #vicinae #server start not at boot
  fuzzel
  #rofi
  gearlever

  # python
  python315
  python313Packages.pip
  pipx
  
  # pirate
  protonvpn-gui
  qbittorrent

  # xorg
  xorg.libXcursor
  xorg.libXi
  xorg.libXinerama
  xorg.libXScrnSaver

  # lib
  libpng
  libpulseaudio
  libvorbis
  stdenv.cc.cc.lib # Provides libstdc++.so.6
  libkrb5
  libjxl
  libadwaita

  # Secureboot
  sbctl

  # LUKS
  tpm2-tools
  tpm2-tss
  tpm2-abrmd

  # Security keys
  fido2-manage
  libfido2
  gnupg

  # General utilities
  swaybg
  home-manager
  btop
  ranger
  kdePackages.filelight
  libreoffice-qt-fresh
  keyutils  
  bluez
  openrgb-with-all-plugins
  kdePackages.discover
  wineWowPackages.waylandFull
  #pkgs.airgeddon
  kdePackages.plasma-browser-integration
  wget
  tpm-tools
  tpm2-tools
  tpm2-tss
  wayland
  rar
  unrar-free
  bat
  usbutils
  tldr
  ffmpeg
  imagemagick
  zip
  unzip
  (uutils-coreutils.override { prefix = ""; })
  nix-prefetch-git
  nixfmt-rfc-style
  statix
  cachix
  clinfo
  solaar
  nettools
  tealdeer
  xclip
  bat

  # AMD
  amdgpu_top # tool to display AMDGPU usage

  # Graphics
  mesa
  mangohud
  gamescope

  # Virtualization stuff
  spice-gtk
  swtpm
  OVMFFull

  # Drivers
  dxvk
  vkd3d-proton 

  # Wine
  wine
  winePackages.waylandFull
  winetricks
  protonup-qt
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

# Activate flakes install
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Shell set up
# for global user
users.defaultUserShell=pkgs.zsh; 
# For a specific user
users.users.xenomorph.shell = pkgs.zsh; 
users.users.xenomorph.useDefaultShell = true;
programs.zsh.enable = true;
# enable zsh and oh my zsh


programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};



  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

services = {  

    flatpak = {
      enable = true;
    };
    fwupd.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
    resolved.enable = true;

    gnome.gnome-keyring.enable = true;
   
 };
 programs = {
    niri.enable = true; # enable niri as window manager
    xwayland.enable = true;
    firefox.enable = true;
    adb.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    nano = {
      enable = true;
      nanorc = "
        set mouse
        set autoindent
        set linenumbers
        set constantshow
        set noconvert
        set preserve
        set smarthome
        set tabsize 4
        set tabstospaces
        set wordbounds
        set zap
        set errorcolor brightwhite,red
    	set functioncolor green
    	set keycolor cyan
    	set numbercolor cyan
    	set selectedcolor brightwhite,magenta
    	set statuscolor cyan
    	set stripecolor ,yellow
    	set titlecolor brightwhite,blue
      ";
      syntaxHighlight = true;
    };
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
      flake = "/etc/nixos/";
    };
    virt-manager = {
      enable = true;
      package = pkgs.virt-manager;
    };

    appimage = {
      enable = true;
      binfmt = true;
    };
  };

 # Virtualization software
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = [ pkgs.virtiofsd ];
        swtpm.enable = true;
        runAsRoot = true;
      };
    };
  };

# Allow unstable packages.
nixpkgs.config = {
  allowUnfree = true;
  packageOverrides = pkgs: {
    unstable = import <unstable> {
      config = config.nixpkgs.config;
    };
  };
};

# Mount disk
 fileSystems."/dev/nvme0n1p1" = {
   device = "/dev/disk/by-uuid/5A157F32-6B48-4FE4-B00D-B194D30AA4B4";
   fsType = "ext4";
   options = [ # If you don't have this options attribute, it'll default to "defaults" 
     # boot options for fstab. Search up fstab mount options you can use
     "users" # Allows any user to mount and unmount
    "nofail" # Prevent system from failing if this drive doesn't mount
     "exec" # Permit execution of binaries and other executable files
     "noatime"
   ];
 };

}


