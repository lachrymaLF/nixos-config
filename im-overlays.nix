final: prev: {
  vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
    postFixup = builtins.replaceStrings [ "app.asar" ] [ "app.asar --set GTK_IM_MODULE fcitx" ] oldAttrs.postFixup; # this sucks
  });
  qq = prev.qq.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/qq --set GTK_IM_MODULE fcitx
    '';
  });
}
