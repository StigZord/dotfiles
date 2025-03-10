-- See `:help gitsigns` to understand what the configuration keys do
-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- Actions
      -- visual mode
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git [s]tage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git [r]eset hunk' })
      -- normal mode
      map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'stage hunk' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'reset hunk' })
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'stage buffer' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'reset buffer' })
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'preview hunk' })
      map('n', '<leader>gl', gitsigns.blame_line, { desc = 'blame line' })
      map('n', '<leader>gdd', gitsigns.diffthis, { desc = 'diff against index' })
      map('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { desc = 'diff against last commit' })
      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'toggle git show blame line' })
      map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'toggle git show deleted' })
    end,
  },
}
