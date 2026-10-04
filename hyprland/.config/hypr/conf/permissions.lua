-- Permission changes require a Hyprland restart.
-- hl.config({ ecosystem = { enforce_permissions = true } })

-- hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hypridle", type = "screencopy", mode = "allow" })
