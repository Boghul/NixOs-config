{
programs.zsh = {
      enable = true;
      shellInit = "fastfetch --kitty-icat ~/Bilder/grimreaper.gif";
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
      "HIST_IGNORE_DUPS"
      "SHARE_HISTORY"
      "HIST_FCNTL_LOCK"
      ];
      histSize = 10000;
      shellAliases = {
        # Navigation
        ".."="cd ..";
        "..."="cd ../..";
        "...."="cd ../../..";
        # cd into the old directory
        #bd="cd $OLDPWD";

        # Listing
        ls="ls -lh --color=auto";
        ll="ls -alh";
        la="ls -A";
        l="ls -CF";

        # Utilities
        grep="grep --color=auto";
        c="clear";
        h="history";
        j="jobs -l";
        pip="pip3";
        python="python3";
        # Remove a directory and all files
        rmd="/bin/rm  --recursive --force --verbose ";

        # Calendar
        jan="cal -m 01";
        feb="cal -m 02";
        mar="cal -m 03";
        apr="cal -m 04";
        may="cal -m 05";
        jun="cal -m 06";
        jul="cal -m 07";
        aug="cal -m 08";
        sep="cal -m 09";
        oct="cal -m 10";
        nov="cal -m 11";
        dec="cal -m 12";

        # Programs & Co
        # fastfetch with gif
        fastgif="fastfetch --kitty-icat ~/Bilder/grimreaper.gif";
        # rebuild nixos
        rebuild="sudo nixos--rebuild switch --flake .";
        # update nixos channels
        channel="nix-channel --update";
        # delete garbage
        garbage="nix-collect-garbage -d --delete-old";
        # CLI musicplayer
        m="musikcube";
        # Cli filemanger
        r="ranger";
        # Show open ports
        openports="netstat -nape --inet";
        };
        ohMyZsh = {
          theme = "mikeh"; # has no effect hen not set in .zshrc ??
          plugins = [ "z" "zstyle" "theme" "git" ];
         # custom = "$HOME/.oh-my-zsh/custom/";
      };
    };

}
