return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      letter_list = 'gfdshla;rueiwovmc,x.qpz/',
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
