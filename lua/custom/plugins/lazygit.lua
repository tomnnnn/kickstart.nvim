return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
      "nvim-lua/plenary.nvim",
  },
  vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Open lazygit floating window' })
}


