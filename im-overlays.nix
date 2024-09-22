# this sucks
final: prev: {
  vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
    postFixup = builtins.replaceStrings [ "app.asar" ] [ "app.asar --set GTK_IM_MODULE fcitx" ] oldAttrs.postFixup;
  });
  qq = prev.qq.overrideAttrs (oldAttrs: {
    installPhase = builtins.replaceStrings [ "--add-flags" ] [ "--set GTK_IM_MODULE fcitx --add-flags" ] oldAttrs.installPhase;
  });
}
