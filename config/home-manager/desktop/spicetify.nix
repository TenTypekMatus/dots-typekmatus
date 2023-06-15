{
let
  spicetify = fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz;
in
# The module is meant to be imported by the user
home-manager.users.piet = {
  imports = [ (import "${spicetify}/module.nix") ];

  programs.spicetify = {
    enable = true;
    theme = "Dribbblish";
    colorScheme = "horizon";
    enabledCustomApps = ["reddit"];
    enabledExtensions = ["newRelease.js" "autoVolume.js"];
    thirdParyExtensions = {
      "autoVolume.js" = "${av}/autoVolume.js";
    };
  };
}
}
