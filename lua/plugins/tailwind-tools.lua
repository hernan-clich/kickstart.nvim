return {
  {
    'luckasRanarison/tailwind-tools.nvim',
    enabled = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('tailwind-tools').setup {
        document_color = {
          kind = 'background',
        },
      }
    end,
    opts = {}, -- your configuration
  },
}
