local colors = require("conf.variables").colors

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 8,
        border_size = 0,
        col = {
            active_border = {
                colors = { colors.crust, "rgba(" .. colors.mantleAlpha .. "00)", colors.crust },
                angle = 0,
            },
            inactive_border = "rgba(" .. colors.baseAlpha .. "00)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
})
