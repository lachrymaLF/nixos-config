{ pkgs, config, lib, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;

#    enabledExtensions = with spicePkgs.extensions; [
#      playlistIcons
#      history
     # genre
#      adblock
#      savePlaylists
     # volumePercentage
#      copyToClipboard
#      songStats
#      hidePodcasts
#      fullAppDisplay
#      groupSession
#      fullAlbumDate
#    ];
  };
}
  
