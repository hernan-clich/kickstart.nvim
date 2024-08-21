return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  init = function()    
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = vim.schedule_wrap(function(data)
        vim.print(vim.fn.isdirectory(data.file))
        if data.file == "" or vim.fn.isdirectory(data.file) ~= 0 then
          vim.print(data.file)
          require("oil").open()
        end
      end),
    })
  end,
}