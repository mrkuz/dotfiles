{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
  ];

  # Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacsUnstable;
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    # client.arguments = [ "-c" "-a" "emacs" ];
  };

  programs.fzf.enable = true;
  services.syncthing = {
    enable = true;
  };

  home.packages = [
   # Emacs dependencies
   pkgs.graphviz
   pkgs.hugo
   pkgs.pandoc
   pkgs.pdftk
   pkgs.plantuml
   pkgs.silver-searcher
   pkgs.sqlite
   pkgs.texlive.combined.scheme-basic
   # Cloud tools
   pkgs.google-cloud-sdk
   pkgs.kubernetes-helm
   pkgs.kubectl
   pkgs.minikube
   # Miscellaneous
   pkgs.gitAndTools.gitFull
   pkgs.gocr
   pkgs.imagemagick
   pkgs.html-tidy
   pkgs.mkvtoolnix-cli
   pkgs.nodejs
   pkgs.protobuf
   # Applications
   pkgs.android-studio
   pkgs.jetbrains.idea-community
   pkgs.netbeans
   pkgs.postman
   pkgs.qbittorrent
   pkgs.robo3t
   pkgs.skypeforlinux
   pkgs.spotify
   pkgs.steam
   pkgs.syncthing-gtk
   pkgs.virtualbox
   pkgs.vscode
  ];
}
