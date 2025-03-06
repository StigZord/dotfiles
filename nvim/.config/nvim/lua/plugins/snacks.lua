return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true, hidden = true },
    indent = {
      enabled = true,
      animate = { enabled = false },
    },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    ---
    styles = {
      notification = {
        relative = 'editor',
        border = 'top',
        zindex = 100,
        ft = 'markdown',
        wo = {
          winblend = 5,
          wrap = false,
          conceallevel = 2,
          colorcolumn = '',
        },
        bo = { filetype = 'snacks_notif' },
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- picker
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Switch to Buffer" },
    {
      '<leader>fc',
      function()
        local config_path = vim.fn.stdpath 'config'
        assert(type(config_path) == "string")
        Snacks.picker.files { cwd = config_path }
      end,
      desc = 'Find Config File',
    },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

    -- project
    { "<leader>pp", function() Snacks.picker.projects() end, desc = "Switch" },

    -- git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  },
}
