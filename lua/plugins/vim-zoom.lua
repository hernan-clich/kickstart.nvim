return {
  {
    'dhruvasagar/vim-zoom',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-w>m', '<Plug>(zoom-toggle)', { desc = 'Zoom into buffer', noremap = false, silent = true })
    end,
  },
}