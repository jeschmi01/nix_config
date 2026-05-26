{ pkgs, ... }:

let
  chosenTheme = "sword";

  qylock-sddm-theme = pkgs.stdenv.mkDerivation {
    pname = "qylock-sddm-sword-theme";
    version = "1.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "Darkkal44";
      repo = "qylock";
      rev = "6946b53626b4f3c1507ae9a78c287411df5fb36c";
      sha256 = "sha256-79SHhz9ATD5ZpOjmOyoVZSrqstddJOfHrs+Drw4nvk0=";
    };

    swordFont = pkgs.fetchurl {
      url = "https://dl.dafont.com/dl/?f=the_last_shuriken";
      sha256 = "sha256-Bfw9IuA/NW7lAYdQNb20d3S8kRAx4GFYmfgIGVGiu+M=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -r "themes/${chosenTheme}" "$out/share/sddm/themes/Sword"
      
      mkdir -p font_temp
      ${pkgs.unzip}/bin/unzip $swordFont -d font_temp
      mkdir -p $out/share/sddm/themes/Sword/font
      cp font_temp/*.ttf $out/share/sddm/themes/Sword/font/the_last_shuriken.ttf || cp font_temp/*.otf $out/share/sddm/themes/Sword/font/the_last_shuriken.otf
    '';
  };
in
{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "Sword";

    extraPackages = [
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qt5compat
      pkgs.kdePackages.qtmultimedia
    ];

    settings = {
      General = {
        InputMethod = "";
      };
    };
  };

  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  environment.systemPackages = [
    qylock-sddm-theme

    pkgs.kdePackages.qtdeclarative
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qt5compat
    pkgs.kdePackages.qtmultimedia
    pkgs.perl

    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
  ];

  environment.sessionVariables = {
    QML2_IMPORT_PATH = "${pkgs.kdePackages.qt5compat}/lib/qt-6/qml:${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml";
  };
}
