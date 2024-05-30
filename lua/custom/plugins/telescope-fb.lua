return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.api.nvim_set_keymap(
          "n",
          "<space>f",
          ":Telescope file_browser<CR>",
          { noremap = true }
        )
    end,
}
