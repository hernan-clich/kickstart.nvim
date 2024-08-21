return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = "ayu_mirage",
        component_separators = { left = '', right = ' ' },
        section_separators = { left = '', right = ' ' },
        disabled_filetypes = {
          statusline = {
            -- 'dashboard',
          },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 10,
          tabline = 10,
          winbar = 10,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        -- lualine_c = { 'filename' },
        -- lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}