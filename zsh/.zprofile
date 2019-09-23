# Set display resolution for the fancy lg monitor:
sudo xrandr --newmode "3840x1600_25.00"  201.50  3840 4008 4400 4960  1600 1603 1613 1626 -hsync +vsync
sudo xrandr --addmode HDMI-1 "3840x1600_25.00"    
export PATH="$HOME/.cargo/bin:$PATH"
