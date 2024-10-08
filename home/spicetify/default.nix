{ pkgs, config, lib, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      history
      betterGenres
      adblock
      savePlaylists
      volumePercentage
      copyToClipboard
      songStats
      hidePodcasts
      fullAppDisplay
      groupSession
      fullAlbumDate
    ];
    enabledCustomApps = with spicePkgs.apps; [
      historyInSidebar
    ];
  };
}
  
