{config, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;
    theme = {
      theme = "nord";
    };
    bars = {
      top = {
        blocks = [
          {
            block = "time";
            interval = 1;
            format = "%a %d/%m %k:%M %p";
          }
          {
            block = "battery";
            interval = 20;
            
          }
        ];
      };
    };
  };
}
