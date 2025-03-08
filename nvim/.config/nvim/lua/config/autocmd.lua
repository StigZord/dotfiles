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

local function is_inside_git_repo(repo_name)
  -- Run `git rev-parse --show-toplevel` to get the root of the Git repo
  local handle = io.popen 'git rev-parse --show-toplevel 2>/dev/null'
  if handle then
    local git_root = handle:read('*a'):gsub('\n', '')
    handle:close()

    -- Check if the Git root contains the target repo name
    return git_root:match(repo_name) ~= nil
  end
  return false
end

-- Check if inside the "dotfiles" Git project and in WSL environment
if is_inside_git_repo 'dotfiles' and vim.env.WSL_DISTRO_NAME then
  -- This autocmd is workaround to copy .wezterm.lua to windows location,
  -- since WSL to Windows symlinks are not recognised by Windows
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '.wezterm.lua', -- Trigger only for this file
    callback = function()
      if not vim.env.WINDOWS_HOME then
        Snacks.notifier.notify('Missing env variable WINDOWS_HOME', 'error')
        return
      end

      vim.fn.system { 'cp', vim.fn.expand '%', vim.env.WINDOWS_HOME .. '/.' }

      if vim.v.shell_error ~= 0 then
        Snacks.notifier.notify('Failed to copy file!', 'error')
      end
    end,
  })
end
