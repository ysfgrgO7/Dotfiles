local appmenu = {}

appmenu.Accessories = {
    { 'ClamTk', 'clamtk' },
    { 'CopyQ', 'copyq --start-server show', '/usr/share/icons/hicolor/128x128/apps/copyq.png' },
    { 'Firejail Configuration Wizard', 'firejail-ui' },
    { 'Gammastep Indicator', 'gammastep-indicator', '/usr/share/icons/hicolor/scalable/apps/gammastep.svg' },
    { 'Kvantum Manager', 'kvantummanager', '/usr/share/icons/hicolor/scalable/apps/kvantum.svg' },
    { 'LunarVim', 'xterm -e lvim' },
    { 'Neovim', 'xterm -e nvim', '/usr/share/icons/hicolor/128x128/apps/nvim.png' },
    { 'PCManFM-Qt File Manager', 'pcmanfm-qt' },
    { 'Software Token', 'stoken-gui' },
    { 'Software Token (small)', 'stoken-gui --small' },
    { 'nitrogen', 'nitrogen', '/usr/share/icons/hicolor/128x128/apps/nitrogen.png' },
    { 'picom', 'picom' },
}

appmenu.Development = {
    { 'CMake', 'cmake-gui', '/usr/share/icons/hicolor/128x128/apps/CMakeSetup.png' },
    { 'Electron 28', 'electron28' },
    { 'Sublime Text', '/usr/bin/subl', '/usr/share/icons/hicolor/128x128/apps/sublime-text.png' },
}

appmenu.Graphics = {
    { 'Flameshot', '/usr/bin/flameshot', '/usr/share/icons/hicolor/128x128/apps/org.flameshot.Flameshot.png' },
    { 'Ristretto Image Viewer', 'ristretto', '/usr/share/icons/hicolor/128x128/apps/org.xfce.ristretto.png' },
}

appmenu.Internet = {
    { 'Avahi SSH Server Browser', '/usr/bin/bssh' },
    { 'Avahi VNC Server Browser', '/usr/bin/bvnc' },
    { 'Brave', 'brave', '/usr/share/icons/hicolor/128x128/apps/brave-desktop.png' },
    { 'Chromium', '/usr/bin/chromium', '/usr/share/icons/hicolor/128x128/apps/chromium.png' },
    { 'Firefox Web Browser', '/usr/lib/firefox/firefox', '/usr/share/icons/hicolor/128x128/apps/firefox.png' },
    { 'Google Chrome', '/usr/bin/google-chrome-stable', '/usr/share/icons/hicolor/128x128/apps/google-chrome.png' },
}

appmenu.Office = {
    { 'BlueMail', 'bluemail', '/usr/share/icons/hicolor/128x128/apps/bluemail.png' },
}

appmenu.MultiMedia = {
    { 'PulseAudio Volume Control', 'pavucontrol' },
    { 'Qt V4L2 test Utility', 'qv4l2', '/usr/share/icons/hicolor/16x16/apps/qv4l2.png' },
    { 'Qt V4L2 video capture utility', 'qvidcap', '/usr/share/icons/hicolor/16x16/apps/qvidcap.png' },
}

appmenu.Settings = {
    { 'ARandR', 'arandr' },
    { 'Advanced Network Configuration', 'nm-connection-editor' },
    { 'Bluetooth Manager', 'blueman-manager', '/usr/share/icons/hicolor/128x128/apps/blueman.png' },
    { 'Customize Look and Feel', 'lxappearance' },
    { 'Desktop', 'pcmanfm-qt --desktop-pref=general' },
    { 'Displays', 'wdisplays', '/usr/share/icons/hicolor/scalable/apps/network.cycles.wdisplays.svg' },
    { 'GTK Settings', 'nwg-look' },
    { 'Kvantum Manager', 'kvantummanager', '/usr/share/icons/hicolor/scalable/apps/kvantum.svg' },
    { 'Monitor Settings', 'lxrandr', '/usr/share/icons/hicolor/16x16/devices/video-display.png' },
    { 'Peux OS Welcome Center', '/usr/local/bin/welcomeapp' },
    { 'Print Settings', 'system-config-printer' },
    { 'PulseAudio Volume Control', 'pavucontrol' },
    { 'Qt5 Settings', 'qt5ct' },
    { 'TLP UI', 'tlpui', '/usr/share/icons/hicolor/128x128/apps/tlpui.png' },
}

appmenu.System = {
    { 'Alacritty', 'alacritty' },
    { 'Applications (bauh)', '/usr/bin/bauh', '/usr/share/icons/hicolor/scalable/apps/bauh.svg' },
    { 'Applications (bauh-tray)', '/usr/bin/bauh-tray', '/usr/share/icons/hicolor/scalable/apps/bauh.svg' },
    { 'Avahi Zeroconf Browser', '/usr/bin/avahi-discover' },
    { 'Firetools', 'firetools' },
    { 'GParted', '/usr/bin/gparted', '/usr/share/icons/hicolor/16x16/apps/gparted.png' },
    { 'Hardware Locality lstopo', 'lstopo' },
    { 'Htop', 'xterm -e htop', '/usr/share/icons/hicolor/scalable/apps/htop.svg' },
    { 'LSHW', '/usr/sbin/gtk-lshw', '/usr/share/lshw/artwork/logo.svg' },
    { 'Manage Printing', 'xdg-open http://localhost:631/', '/usr/share/icons/hicolor/128x128/apps/cups.png' },
    { 'Print Settings', 'system-config-printer' },
    { 'Timeshift', 'timeshift-launcher', '/usr/share/icons/hicolor/128x128/apps/timeshift.png' },
    { 'fish', 'xterm -e fish' },
    { 'kitty', 'kitty', '/usr/share/icons/hicolor/256x256/apps/kitty.png' },
    { 'ranger', 'xterm -e ranger' },
}

appmenu.Miscellaneous = {
    { 'Rofi', 'rofi -show', '/usr/share/icons/hicolor/apps/rofi.svg' },
    { 'Rofi Theme Selector', 'rofi-theme-selector', '/usr/share/icons/hicolor/apps/rofi.svg' },
}

appmenu.Appmenu = {
    { 'Accessories', appmenu.Accessories },
    { 'Development', appmenu.Development },
    { 'Graphics', appmenu.Graphics },
    { 'Internet', appmenu.Internet },
    { 'Office', appmenu.Office },
    { 'MultiMedia', appmenu.MultiMedia },
    { 'Settings', appmenu.Settings },
    { 'System', appmenu.System },
    { 'Miscellaneous', appmenu.Miscellaneous },
}

return appmenu