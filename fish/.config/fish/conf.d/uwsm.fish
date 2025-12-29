# start hyprland
if which uwsm &> /dev/null && uwsm check may-start 
    exec uwsm start hyprland-uwsm.desktop
end
