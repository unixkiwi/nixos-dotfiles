{
  config,
  lib,
  pkgs,
  ...
}:
let
  c = config.lib.stylix.colors;
in
{
  home.packages = with pkgs; [
    nautilus
    bibata-cursors
    qalculate-gtk
    grimblast
  ];

  programs = {
    vicinae = {
      enable = true;
      settings = {
        escape_key_behavior = "close_window";
        close_on_focus_loss = true;
        pop_to_root_on_close = true;
        keybinding = "default";
        font.normal.size = 13;
        theme.dark = "gruvbox-dark";
        theme.light = "gruvbox-light";
        launcher_window = {
          opactive = 1;
          blur.enabled = false;
          dim_around = false;
          client_side_decorations.enabled = true;
        };
        systemd = {
          enable = true;
          autoStart = true;
          environment = {
            USE_LAYER_SHELL = 1;
          };
        };
      };
    };

    wofi = {
      enable = true;

      settings = {
        show = "drun";
        allow_markup = true;
        allow_images = true;
        image_size = 32;
        sort_order = "alphabetical";
        matching = "multi-contains";
        insensitive = true;
        no_actions = true;
        parse_search = true;

        width = "30%";
        height = "40%";
        dynamic_lines = false;
      };

      style = ''
        #window {
            border: 1px solid white;
            border-radius: 10px;
        }

        #outer-box {
            padding: 7px;
        }

        #input {
            margin: 0px 0px 5px 0px;
        }

        #entry:selected {T
            border-radius: 7px;
        }

        #img {
            padding-right: 7px;
        }

        #text {
            font-family: monospace;
            font-size: 15px;
        }
      '';
    };

    hyprpanel = {
      enable = true;
    };

    waybar = {
      enable = false;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 20;
          spacing = 0;

          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "wireplumber"
            "tray"
            "network"
            "temperature"
            "battery"
            "clock"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            warp-on-scroll = false;
            format = "{icon}";
          };

          "hyprland/window" = {
            format = "{initialTitle}";
            icon = true;
            separate-outputs = true;
          };

          "wireplumber" = {
            format = "{volume}%";
            format-muted = "";
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };

          "tray" = {
            spacing = 10;
          };

          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };

          "temperature" = {
            critical-threshold = 90;
            format = "{temperatureC}°C {icon}";
            format-icons = [
              ""
              ""
              ""
            ];
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "network" = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected !";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
        };
      };
      style = ''
        * {
          font-family: "CaskaydiaCove Nerd Font", "Font Awesome 6 Free", sans-serif;
          font-size: 1em;
          font-weight: bold;
          transition: none;
          box-shadow: none;
          text-shadow: none;
        }

        window#waybar {
          background-color: #${c.base00};
          color: #${c.base05};     
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        button {
          padding: 0.3em 0.6em;
        }

        #window {
          color: #${c.base05};
        }

        #workspaces button {
          background-color: #${c.base01};
          color: #${c.base05};  
          font-weight: bolder;
          margin: 0.3rem 0.2rem;
          border-radius: 7px;
        }

        #workspaces button:hover {
          background-color: #${c.base02};
          color: #${c.base06};
        }

        #workspaces button.active {
          background-color: #${c.base0D};
          color: #${c.base00};
        }

        #workspaces button.urgent {
          background-color: #${c.base08};
          color: #${c.base00};
        }

        #clock,
        #battery,
        #temperature,
        #network,
        #tray,
        #wireplumber {
          padding: 0.2em 1em;
          margin: 0.3em 0.2em;
          border-radius: 7px;
          background-color: #${c.base01};
        }

        #battery.critical:not(.charging),
        #network.disconnected,
        #temperature.critical {
          background-color: #${c.base08};
          color: #${c.base00};
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #${c.base08};
          color: #${c.base00};
        }
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    settings = {
      "monitor" = [
        "eDP-1,disable"
        "HDMI-A-1,3840x2160@30,0x0,1.25"
      ];

      # --- Variables ---
      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";
      "$menu" = "vicinae toggle";
      "$menu_2" = "walker --modules applications,emojis,calc,runner";
      "$mainMod" = "SUPER";

      # --- Autostart ---
      "exec-once" = [
        "hyprctl setcursor Bibata-Original-Classic 24"
        "systemctl --user start hyprpolkitagent"
        "vicinae server"
        # "WALL=$(find ~/Pictures/walls/ -type f | shuf -n1); matugen image \"$WALL\"; swaybg -i \"$WALL\""
        "swaync &"
        "killall waybar || waybar &"
        "blueman-applet &"
        "nm-applet &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "signal-desktop --start-in-tray --no-sandbox"
        "udiskie -tn &"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
        "gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'"
        "archcare_weekly_prompt"
      ];

      # --- Environment Variables ---
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "GDK_BACKEND,wayland,x11,*"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "GDK_SCALE,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        # Nvidia
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "CUDA_VISIBLE_DEVICES,0,1"
        "NVD_BACKEND,direct"
      ];

      # --- Look and Feel ---
      general = {
        gaps_in = 5;
        gaps_out = 7;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = false;
          range = 7;
          render_power = 10;
        };
        blur = {
          enabled = false;
          size = 3;
          passes = 3;
          ignore_opacity = true;
          new_optimizations = true;
          vibrancy = 0.1696;
          xray = false;
        };
      };

      animations = {
        enabled = false;
        animation = [
          "windows, 1, 7, default, slide"
          "windowsOut, 1, 5, default, slide"
          "border, 1, 3, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default,"
          "workspaces, 1, 1, default,"
          "specialWorkspace, 1, 2, default, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
        focus_on_activate = true;
        enable_anr_dialog = false;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      # --- Input ---
      input = {
        kb_layout = "de";
        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      # --- Keybindings ---
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 1"
        "$mainMod SHIFT, F, fullscreen,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod SHIFT, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
        "$mainMod, SUPER_L, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, C, exec, qalculate-gtk"
        "$mainMod, B, exec, alacritty --class floating -e btop"
        "$mainMod SHIFT, R, exec, killall waybar; waybar &"
        "$mainMod, R, exec, hyprctl reload"
        "SUPER, O, exec, hyprctl dispatch pin"
        "$mainMod, N, exec, swaync-client -t -sw"
        ", PRINT, exec, grimblast --notify copysave area"
        # Focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        # Move
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"
        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod CTRL, h, workspace, e-1"
        "$mainMod, l, workspace, e+1"
        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        # Audio
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      # Bind repeat
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      # Mouse binds
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # --- Window Rules ---
      windowrule = [
        "suppress_event maximize, match:class .*"
        "float on, match:class floating"
        "float on, match:class qalculate-gtk"
        "float on, match:class xdg-desktop-portal-gtk"
        "center on, match:class xdg-desktop-portal-gtk"
      ];
    };
  };
}
