local programs = require("conf.variables")

-- Equivalent to exec-once: these run at session startup, not on config reload.
hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- obsidian", { workspace = "1 silent" })
    hl.exec_cmd("uwsm app -- zen-browser", { workspace = "2 silent" })
    hl.exec_cmd("uwsm app -- " .. programs.terminal, { workspace = "3 silent" })
    hl.exec_cmd("uwsm app -- 1password --silent")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
