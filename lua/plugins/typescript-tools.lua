return {
  {
    'pmizio/typescript-tools.nvim',
    enabled = true,
    cond = not vim.g.vscode,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused', 'remove_unused_imports' },
      },
    },
    keys = {
      { '<leader>ta', '<cmd>TSToolsFixAll<CR>', desc = 'Fix all files' },
      { '<leader>ti', '<cmd>TSToolsAddMissingImports<CR>', desc = 'Add missing imports' },
      { '<leader>tr', '<cmd>TSToolsRemoveUnused<CR>', desc = 'Remove unused' },
      { '<leader>tu', '<cmd>TSToolsRemoveUnusedImports<CR>', desc = 'Remove unused imports' },
    },
  },
}
