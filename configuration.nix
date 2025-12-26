# #not finshed yet, still in work!

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan
      ./flatpak.nix
      #./default.nix
    ];

  # Bootloader
  boot = {
   initrd = {
      availableKernelModules = [
        "xhci_pci"
        "usb_storage"
        "nvme"
        "ext4"
        "ext3"
        "btrfs"
        "vfat"
        ];
   kernelModules = [ "amdgpu" ];
   };
   loader = {
     systemd-boot = {
       enable = false;
       configurationLimit = 10; # Show up to 10 generations
        };
     limine = {
        enable = true;
        efiSupport = true;  # For UEFI systems
        biosSupport = false; # For BIOS systems
        secureBoot.enable = true;
        maxGenerations = 16;
        validateChecksums = true;
        #biosDevice = "/dev/disk/by-uuid/cc0d4cdd-d718-43a9-bec3-df77c8e0eab4";
        style = {
          wallpapers = [ /home/xenomorph/Bilder/bootloaderpic/A-Xenomorph-and-a-Yuatja-squaring-off-about-to-fight-in-Dark-Horse-Comics.png ];
          wallpaperStyle = "stretched"; # centered, tiled or stretched
          #backdrop = "7EBAE4"; # used when wallpaperstyle set to centered
          interface = {
              branding = "with great power comes great responsibility"; # The title at the top of the screen.
              brandingColor = 2;
              };
          };
      };
      efi.canTouchEfiVariables = true;
  };

  # Use latest kernel.
  kernelPackages =  pkgs.linuxPackages_latest;
  kernelParams = [
      "radeon.si_support=1"
      "amdgpu.si_support=0"
      "amdgpu.dc=1"
      "amd_iommu=on"
      "acpi_osi=Linux"
      "quiet"
      "splash"
      "amdgpu.ppfeaturemask=0xfffd3fff" # for disabling STUTTER_MODE and GFXOFF
      "split_lock_detect=off"
      ];
    kernelModules = [
      "kvm-amd"
      "amdgpu"
      "tpm_cbr"
      ];
    extraModprobeConfig = "options amdgpu ppfeaturemask=0xffffffff\n\n"; # enables overclocking features
    bootspec = {
      enableValidation = true;
      };
};
 # Network
 networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager = {
      enable = true;
      ethernet.macAddress = "random";
      #wifi.macAddress = "random";
      };
    modemmanager.enable = true;
    wireguard.enable = true;
    firewall = {
   #   allowedTCPPorts = [ ... ];
   #   allowedUDPPorts = [ ... ];
       trustedInterfaces = [
        "enp11s0"
        "wlp10s0"
        "proton0"
        ];
   # Or disable the firewall altogether.
   #   enable = false;
   };
   #proxy = {
   # Configure network proxy if necessary
   # default = "http://user:password@proxy:port/";
   # noProxy = "127.0.0.1,localhost,internal.domain";};
   # };
   # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
};

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
      fontconfig.defaultFonts.serif = [ "source-code-pro" ];
};

services = {
    flatpak = {
        enable = true;
        };
    fwupd.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
    resolved.enable = true;
    gnome.gnome-keyring.enable = true;
    clamav = {
        daemon.enable = true;
        updater.enable = true;
        scanner.interval = "04:00:00";
        };
    protonmail-bridge = {
        enable = true;
        logLevel = "info"; # Options: panic, fatal, error, warn, info, debug
        };
  # Enable CUPS to print documents.
    printing.enable = true;
  # Enable the KDE Plasma Desktop Environment.
    displayManager = {
        sddm = {
            enable = true;
            wayland.enable = true;
            theme = "sddm-astronaut-theme";
            extraPackages = [ pkgs.sddm-astronaut
                              pkgs.sddm-sugar-dark
                              pkgs.catppuccin-sddm
                              pkgs.catppuccin-sddm-corners
                              pkgs.elegant-sddm
                              pkgs.sakura
                              pkgs.where-is-my-sddm-theme
                            ];
            };
         };
       desktopManager.plasma6.enable = true;
     # Configure keymap in X11
    xserver = {
        displayManager.startx.enable = true;
        xkb = {
            layout = "de";
            variant = "deadacute";
            };
            videoDrivers = [ "amdgpu" ];
    };
  # enable openrgb
    hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = "amd";
        server = {
            port = 6742;
            };
        };
  # BluetoothManager
    blueman.enable = true;

  # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # t o find the controller and product ID of a device usbutils might be useful
  #udev.extraRules = ''
  #  SUBSYSTEM=="input", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="3106", MODE="0660", GROUP="input"
  #'';
  };
  solaar = {
    enable = true; # Enable the service
    package = pkgs.solaar; # The package to use
    window = "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };

  # Logitech mx master 3s setup
    udev.extraRules = ''
    # Allows non-root users to have raw access to Logitech devices.
    # Allowing users to write to the device is potentially dangerous
    # because they could perform firmware updates.
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
    ACTION == "remove", GOTO="solaar_end"
    SUBSYSTEM != "hidraw", GOTO="solaar_end"
    # USB-connected Logitech receivers and devices
    ATTRS{idVendor}=="046d", GOTO="solaar_apply"
    # Lenovo nano receiver
    ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"
    # Bluetooth-connected Logitech devices
    KERNELS == "0005:046D:*", GOTO="solaar_apply"
    GOTO="solaar_end"
    LABEL="solaar_apply"
    # Allow any seated user to access the receiver.
    # uaccess: modern ACL-enabled udev
    TAG+="uaccess"
    # Grant members of the "plugdev" group access to receiver (useful for SSH users)
    #MODE="0660", GROUP="plugdev"
    LABEL="solaar_end"
    # vim: ft=udevrules
    '';

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Hardware Configuration #Steam #Controller #OpenGL #fwupd
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd # OpenCL
        libva # VA-API
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
        mesa.opencl
        ];
      extraPackages32 = [ ];
    };
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      overdrive.enable = true;
      };
    steam-hardware.enable = true;
    xone.enable = true;
    xpadneo.enable = true;
    cpu.amd.updateMicrocode = true;

    logitech.wireless.enable = true;
    bluetooth = {
        enable = true;
        package = pkgs.bluez;
        powerOnBoot = true;
        settings = {
            General = {
                # Shows battery charge of connected devices on supported
                #Bluetooth adapters. Defaults to 'false'.
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

 # Security
  security = {
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
    protectKernelImage = true;
    forcePageTableIsolation = true;
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      abrmd = {
        enable = true;
      };
      pkcs11 = {
        enable = true;
      };
      tctiEnvironment = {
        enable = true;
      };
    };
    # superuser
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "xenomorph" ]; # Replace "xenomorph" with your username
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo ={
      enable = true;
      wheelNeedsPassword = false;
      };
    };

  users = {
  defaultUserShell=pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.xenomorph = {
    isNormalUser = true;
    description = "Thorsten";
    shell = pkgs.zsh;
    useDefaultShell = true;
    extraGroups = [ "networkmanager"
		    "wheel"
	  	    "audio"
		    "gamemode"
       		    "cpugovctl"
       		    "sysctlgroup"
       		    "libvirtd"
       		    "kvm"
       		    "input"
       		    "tss"
       		      ];
    packages = with pkgs; [ ];
   };
};

  environment = {
    sessionVariables = {
    AMD_VULKAN_ICD           = "RADV";
    PROTON_USE_NTSYNC        = "1";
    ENABLE_HDR_WSI           = "1";
    DXVK_HDR                 = "1";
    PROTON_ENABLE_AMD_AGS    = "1";
    PROTON_ENABLE_NVAPI      = "1";
    ENABLE_GAMESCOPE_WSI     = "1";
    STEAM_MULTIPLE_XWAYLANDS = "1";
    GTK_THEME                = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME     = "kde";
    EDITOR                   = "kate";
};
  # List packages installed in system profile. To search, run:
  #$ nix search wget
  systemPackages = with pkgs; [
  # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  # pkgs.vimPlugins.clever-f-vim

  # Bootloader
  limine

  # sddm theme
  sddm-astronaut

  # Terminal tools
  kitty
  wget
  fastfetch
  ninja
  cmake
  gnumake
  clang
  clinfo
  curl
  git
  tree
  gnugrep
  asciiquarium
  btop
  ranger
  ffmpeg
  bat
  nettools
  strace

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
  legendary-gl # epic launcher
  steam

  steam-run
  protonplus
  pavucontrol

  # Communication
  wasistlos
  signal-desktop
  protonmail-desktop
  protonmail-bridge
  thunderbird

  # programs
  #vicinae #server start not at boot
  fuzzel
  gearlever
  libreoffice-qt-fresh
  openrgb-with-all-plugins
  seahorse
  solaar
  gparted
  eww

  # kde pkgs
  kdePackages.filelight
  kdePackages.discover
  kdePackages.plasma-browser-integration
  kdePackages.kate
  kdePackages.ktexteditor
  kdePackages.breeze-gtk
  kdePackages.breeze-icons

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
  xorg.libxcb

  # lib
  libpng
  libpulseaudio
  libvorbis
  stdenv.cc.cc.lib # Provides libstdc++.so.6
  libkrb5
  libjxl
  libadwaita
  libxcb
  libsndfile
  libtheora
  libogg
  libopus
  libGLU
  libpcap
  libao
  libevdev
  libgcrypt
  libxml2
  libusb1
  libmpeg2
  libv4l
  libjpeg
  libxkbcommon
  libass
  libcdio
  libjack2
  libsamplerate
  libzip
  libmad
  libaio
  libcap
  libtiff
  libva
  libgphoto2
  libxslt

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
  clamav
  gnome-keyring

  # General utilities
  rustc
  cargo
  swaybg
  home-manager
  keyutils
  bluez
  dconf
  #pkgs.airgeddon
  wayland
  wayland-utils
  rar
  unrar-free
  disko
  usbutils
  tldr
  imagemagick
  zip
  unzip
  (uutils-coreutils.override { prefix = ""; })
  nix-prefetch-git
  nixfmt-rfc-style
  statix
  cachix
  tealdeer
  xclip
  xhost
  xwayland-satellite
  xcb-util-cursor
  nixos-generators
  #mesa.opencl

  # OBS
  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
      ];
  })

  # commands that lutris needs
  xrandr
  pciutils
  psmisc
  mesa-demos
  p7zip
  xgamma
  gettext
  libstrangle
  fluidsynth
  util-linux
  pkg-config
  desktop-file-utils
  appstream-glib

  # AMD
  amdgpu_top # tool to display AMDGPU usage

  # Graphics
  mesa
  mangohud
  gamescope
  gamemode
  vulkan-tools
  vulkan-loader
  vulkan-validation-layers
  vulkan-extension-layer
  opencl-headers

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
  wineWowPackages.waylandFull
  winetricks
  protonup-qt
  protontricks
  cups
  lcms2
  mpg123
  cairo
  unixODBC
  samba4
  sane-backends
  openldap
  ocl-icd
  util-linux
  libselinux
  fribidi
  pango
  umu-launcher
  devenv
  ];
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
  #   enableSSHSupport = true;
   };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
     # substituters = ["https://nix-gaming.cachix.org"];
     # trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
      };
};

# Steam
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local NentworkGame
  extest.enable = true;
  gamescopeSession.enable = true;
  extraCompatPackages = with pkgs; [
  proton-ge-bin
  ];
  protontricks.enable = true;

  package = pkgs.steam.override {
  extraPkgs = pkgs': with pkgs'; [
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    libpng
    libpulseaudio
    libvorbis
    stdenv.cc.cc.lib # Provides libstdc++.so.6
    libkrb5
    keyutils
    SDL2
    libjpeg
    pango
    harfbuzz
    # Add other libraries as needed
    ];
  };
};



  nixpkgs = {
    hostPlatform = "x86_64-linux";
    # Allow unstable & unfree packages.
    config = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "steam"
            "steam-original"
            "steam-unwrapped"
            "steam-run"
            "proton-ge-bin"
            ];
        allowUnfree = true;
        packageOverrides = pkgs: {
            unstable = import <unstable> {
                config = config.nixpkgs.config;
                };
            };
        };
};

 programs = {
    niri.enable = true; # enable niri as window manager
    xwayland.enable = true;
    firefox.enable = true;
    adb.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [{
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
        }];
    };
    gamescope = {
        enable = true;
        capSysNice = true;
        };
    gamemode = {
      enable = true;
      settings = {
        gpu = {
          apply_gpu_optimizations = "accept-responsibility";
          gpu_device = 0;
        };
      };
    };
    obs-studio.enable = true;
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

    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = {"rm -rf *" = "fg=white,bg=red";};
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
     setOptions = [
      "AUTO_CD"
      ];
      histSize = 10000;
      #shellAliases = { };
      ohMyZsh.theme = "mikeh";
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

# Mount disk
 fileSystems."/" = {
   device = "/dev/disk/by-uuid/cc0d4cdd-d718-43a9-bec3-df77c8e0eab4";
   fsType = "ext4";
   options = [ # If you don't have this options attribute, it'll default to "defaults"
     # boot options for fstab. Search up fstab mount options you can use
     "users" # Allows any user to mount and unmount
     "nofail" # Prevent system from failing if this drive doesn't mount
     "exec" # Permit execution of binaries and other executable files
     "noatime"
   ];
 };
 fileSystems."/boot" = {
  device = "/dev/disk/by-uuid/159D-4E20";
  fsType = "vfat";
  options = [ "nofail"
               "fmask=0077"
               "dmask=0077"
               ];
  };
    system.autoUpgrade = {
        enable = true;
        };


  qt = {
    style = "adwaita-dark";
    enable= true;
    platformTheme = "kde";
    };



}
