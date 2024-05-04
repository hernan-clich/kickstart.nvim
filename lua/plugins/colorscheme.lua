return {
  'loctvl842/monokai-pro.nvim',
  opts = {
    filter = 'machine',
  },
  init = function()
    vim.cmd 'colorscheme monokai-pro'
  end,
}
