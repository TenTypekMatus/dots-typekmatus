{config, pkgs, lib, ...}:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "alacritty";
    };
    extraConfig = ''
      font pango:Agave Nerd Font Bold 14
      bindsym Mod4+d "wofi --show drun --allow-images"
      exec swayidle -w \
        timeout 300 'swaylock-fancy' \
        timeout 600 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' \
        before-sleep 'swaylock-fancy'

      for_window [class="^.*"] border pixel 2
      smart_gaps on
      gaps inner 15
      gaps outer 15
      bar {
      position top
      status-command i3blocks -c ~/.config/i3blocks/config

      colors {
            separator  #1f222d
            background #1f222d
            statusline #81a1c1

            #                   border  background text
            focused_workspace  #1f222d #1f222d    #81a1c1
            active_workspace   #1f222d #252936    #5e81ac
            inactive_workspace #1f222d #1f222d    #4c566a
            urgent_workspace   #1f222d #1f222d    #ee829f
            binding_mode       #1f222d #81a1c1    #2e3440
      }
      }
     # class                 border  backgr. text    indicator
      client.focused          #81a1c1 #81a1c1 #ffffff #81a1c1
      client.unfocused        #2e3440 #1f222d #888888 #1f222d
      client.focused_inactive #2e3440 #1f222d #888888 #1f222d
      client.placeholder      #2e3440 #1f222d #888888 #1f222d
      client.urgent           #900000 #900000 #ffffff #900000

      client.background       #242424
    '';
  };
}
