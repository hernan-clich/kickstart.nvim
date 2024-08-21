return {
  "akinsho/bufferline.nvim",
  enabled = true,
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  },
  opts = {
    options = {
      indicator = { style = "none" },
      show_buffer_close_icons = true,
      show_close_icon = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true, -- use a "true" to enable the default, or set your own character
        },
      },
    },
  },
}
