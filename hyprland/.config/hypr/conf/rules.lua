-- Workspaces: retain numeric IDs, display names, monitor assignments and persistence.
hl.workspace_rule({ workspace = "1", default_name = "obsidian", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "2", default_name = "web", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "3", default_name = "vim", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "4", default_name = "discord", monitor = "DP-2", persistent = false })
hl.workspace_rule({ workspace = "9", default_name = "dev", monitor = "eDP-1", persistent = true })

hl.window_rule({ name = "float-1password", match = { class = "1Password" }, float = true })
hl.window_rule({ name = "tag-weave-dev", match = { class = "Weave" }, tag = "dev" })
hl.window_rule({ match = { class = "dev" }, tag = "dev", workspace = "name:dev silent" })
hl.window_rule({
	name = "discord-workspace",
	match = { class = "discord" },
	tag = "discord",
	workspace = "name:discord",
})
hl.window_rule({ name = "dev-workspace", match = { tag = "dev" }, workspace = "name:dev" })
hl.window_rule({ name = "dev-no-initial-focus", match = { tag = "dev" }, no_initial_focus = true })
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})
