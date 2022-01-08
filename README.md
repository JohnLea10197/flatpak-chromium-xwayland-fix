# Flatpak Chromium Fixes for Xwayland <br>  

## Under Nvidia GBM (maybe on other hardware too) the flatpak version of chromium doesn't properly work so I set up this workaround

I created this for myself for learning purposes, and because I wanted to get it working on XWayland. 
Since this uses launch options to force Chromium to use Wayland instead of XWayland, it's also likely a very buggy experience. <br>  <br>  

# Bugs are inevitable, and although it works for me and my use case I cannot guarantee it will for you, use at your own risk. <br>  

## Keep in mind that this also uses $XDG_SESSION_TYPE to detect if it's Wayland or X11 which doesn't work for all compositors/window managers.
