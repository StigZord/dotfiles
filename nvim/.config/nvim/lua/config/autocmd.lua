-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  desc = 'Save on nvim focus lost',
  group = vim.api.nvim_create_augroup('auto-save', { clear = true }),
  callback = function(args)
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
      -- For some reason when triggered update via nvim_command
      -- conform wasn't formatting automatically so it needs to be called explicitly here
      require('conform').format { bufnr = args.buf, timeout_ms = 500 }
      vim.api.nvim_command 'silent update'
    end
  end,
})
