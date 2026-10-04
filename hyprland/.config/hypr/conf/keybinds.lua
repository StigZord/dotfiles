local programs = require("conf.variables")
local mainMod = "SUPER"

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/wallpaper.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- zen-browser"))
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("uwsm app -- " .. programs.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.exec_cmd("systemctl suspend"))

-- Arrow keys and Vim keys move focus in the same directions.
for key, direction in pairs({ left = "left", down = "down", up = "up", right = "right", h = "left", j = "down", k = "up", l = "right" }) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
end

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = true }))
end

hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("systemctl --user restart waybar.service"))

hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind("ALT + space", hl.dsp.submap("leader"))
hl.define_submap("leader", function()
    hl.bind("h", hl.dsp.focus({ workspace = "m-1" }))
    hl.bind("l", hl.dsp.focus({ workspace = "m+1" }))

    -- Each shortcut both switches workspace and leaves the leader submap.
    for key, workspace in pairs({ u = "name:obsidian", i = "name:web", b = "name:web", o = "name:vim", y = "name:dev" }) do
        hl.bind(key, function()
            hl.dispatch(hl.dsp.focus({ workspace = workspace }))
            hl.dispatch(hl.dsp.submap("reset"))
        end)
    end

    -- The original leader-move definition is commented out. Keep its shortcut
    -- inactive until the submap is restored, instead of targeting a missing submap.
    -- hl.bind("m", hl.dsp.submap("leader-move"))

    hl.bind("f", function()
        hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
        -- Lua centering respects reserved monitor space, like centerwindow 1.
        hl.dispatch(hl.dsp.window.center())
    end)
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys keep working while locked; volume and brightness also repeat.
local repeatingLocked = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeatingLocked)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeatingLocked)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeatingLocked)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeatingLocked)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), repeatingLocked)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), repeatingLocked)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
