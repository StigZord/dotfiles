-- Require this table from each module that needs the shared programs or colors.
local variables = {
    terminal = "ghostty",
    fileManager = "dolphin",
    menu = "rofi -show drun",
    colors = require("conf.theme.catppuccin-mocha"),
}

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

return variables
