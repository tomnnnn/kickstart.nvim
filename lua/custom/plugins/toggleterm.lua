return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup{
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        direction = "vertical"
      }

    -- lazygit
      local Terminal  = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true, desc = "Toggle lazygit window"})

    -- additional keymaps
      vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal <CR>', {noremap = true, silent = true, desc = "Set toggleterm direction to horizontal"})
      vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical <CR>', {noremap = true, silent = true, desc = "Set toggleterm direction to vertical"})
      vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float <CR>', {noremap = true, silent = true, desc = "Set toggleterm direction to float"})
    end,
}
