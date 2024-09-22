final: prev: {
  vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/vesktop --set GTK_IM_MODULE fcitx
    '';
  });
  qq = prev.qq.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/vesktop --set GTK_IM_MODULE fcitx
    '';
  });
}
