return {
  { -- Autoformat
    'stevearc/conform.nvim',
    enabled = true,

    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local conform = require 'conform'

      conform.setup {
        quiet = true,
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          svelte = { 'prettier' },
          css = { 'prettier' },
          html = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          graphql = { 'prettier' },
          liquid = { 'prettier' },
          lua = { 'stylua' },
          python = { 'isort', 'black' },
        },
        format_on_save = function()
          if vim.g.disable_autoformat then
            return
          end

          vim.cmd 'silent! EslintFixAll'

          return {
            lsp_fallback = true,
            timeout_ms = 500,
          }
        end,
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = 'Format file or range (in visual mode)' })
    end,
  },
}

