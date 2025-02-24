local jumpToDefinition = function(open_float)
  require('flash').jump {
    labels = 'fjdkslgha;ruvmeic,wox.qpz/',
    label = { after = false, before = true, style = 'overlay', min_pattern_length = 0 },
    search = { mode = 'search', max_length = 0, autojump = true },
    pattern = '.',
    autojump = true,
    matcher = function(win)
      local diagnostics = vim.diagnostic.get(vim.api.nvim_win_get_buf(win))
      ---@param diag vim.Diagnostic
      return vim.tbl_map(function(diag)
        return {
          win = win,
          pos = { diag.lnum + 1, diag.col },
          end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
        }
      end, diagnostics)
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      local cursor_pos = vim.api.nvim_win_get_cursor(0) -- (row, col)
      local cursor_row, cursor_col = cursor_pos[1], cursor_pos[2]

      local function get_distance(match)
        local row, col = match.pos[1], match.pos[2]
        local row_delta = math.abs(cursor_row - row)
        if row_delta == 0 then
          return math.abs(cursor_col - col) - 100
        end

        return row_delta
      end

      table.sort(matches, function(a, b)
        return get_distance(a) < get_distance(b)
      end)

      for index, match in ipairs(matches) do
        match.label = labels[index]
      end
    end,
    action = function(match, state)
      if open_float then
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          vim.diagnostic.open_float { scope = 'cursor' }
        end)
        state:restore()
      else
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
        end)
      end
    end,
  }
end

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'fjdkslgha;ruvmeic,wox.qpz/',
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
  keys = {
  -- stylua: ignore start
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<leader>tf", mode = { "n" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    { "<c-a>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    -- stylua: ignore end
    {
      '<leader>gd',
      mode = { 'n', 'x' },
      function()
        jumpToDefinition(false)
      end,
      desc = 'Jump to diagnostic',
    },
    {
      '<leader>gD',
      mode = { 'n', 'x' },
      function()
        jumpToDefinition(true)
      end,
      desc = 'Preview diagnostic',
    },
  },
}
