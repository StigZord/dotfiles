-- Init vim options
require 'config.options'
require 'config.keymaps'
require 'config.autocmd'
require 'config.lazy'

require('lazy').setup({
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.neo-tree',
  { import = 'plugins' },

  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  change_detection = {
    notify = false,
  },
})
