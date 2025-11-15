{ config, pkgs, services,... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "krypion17";
  home.homeDirectory = "/home/krypion17";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
   # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    gnomeExtensions.appindicator
    python3Packages.pip
    spicetify-cli
    element-desktop
    gnomeExtensions.pano
    gnome-tweaks
    # android-studio
    hyprland
    hyprshot
    playerctl
    adw-gtk3
    nwg-look
    # ags
    #astal.io
    rofi
    zoom-us
    # (pkgs.callPackage ./duckstation/package.nix {  })
    # aseprite
    bitwarden-desktop
  ];


  /*nixpkgs.overlays = [
    (self: super: {
      ags = super.ags.override {
        extraPackages = with pkgs; [ graphene gtk4 astal.gjs astal.hyprland astal.battery astal.wireplumber ];
      };
    })
  ];*/

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-plug
    ];
  };

  # home.file.".mozilla/firefox/random/chrome/firefox-gnome-theme".source = (fetchTarball "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz");

  programs.firefox = {
    enable = true;
    # profiles.random = {
    #   name = "random";
    #   settings = {
    #      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

    #      # For Firefox GNOME theme:
    #      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #      "browser.tabs.drawInTitlebar" = true;
    #      "svg.context-properties.content.enabled" = true;
    #   };
    #   userChrome = ''
    #      @import "firefox-gnome-theme/userChrome.css";
    #      @import "firefox-gnome-theme/theme/colors/dark.css"; 
    #   '';
    # };
  };

  nixpkgs.config.element-web.conf = {
    show_labs_settings = true;
    default_theme = "dark";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/krypion17/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
