return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'microsoft/vscode-js-debug',
      -- After install, build it and rename the dist directory to out
      build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
      version = '1.*',
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('dap-vscode-js').setup {
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = { 'node', 'pwa-node', 'node-terminal' },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        }
      end,
    },

    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
      keys = {
        {
          '<leader>du',
          function()
            require('dapui').toggle {}
          end,
          desc = 'Dap UI',
        },
        {
          '<leader>de',
          function()
            require('dapui').eval()
          end,
          desc = 'Eval',
          mode = { 'n', 'v' },
        },
      },
      opts = {},
      config = function(_, opts)
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open {}
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close {}
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close {}
        end
      end,
    },
  },
  init = function()
    vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = 'DapStopped' })

    -- vim.api.nvim_create_autocmd('FileType', {
    --   desc = 'Attach autocompletion to "dap-repl" filetype',
    --   pattern = 'dap-repl',
    --   group = vim.api.nvim_create_augroup('repl-autocompletion', { clear = true }),
    --   callback = function()
    --     require('dap.ext.autocompl').attach()
    --   end,
    -- })
  end,

  keys = {
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'DAP: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'DAP: Clear Breakpoints',
    },
    {
      '<leader>dc',
      function()
        ---Load most recent `.vscode/launch.json` config
        ---https://github.com/mfussenegger/nvim-dap/issues/20#issuecomment-1356791734
        -- require('dap.ext.vscode').load_launchjs(nil, vscode_type_to_ft)
        if vim.fn.filereadable '.vscode/launch.json' then
          require('dap.ext.vscode').load_launchjs()
        end
        require('dap').continue()
      end,
      desc = 'DAP: Start/Continue (F5)',
    },
    {
      '<leader>dC',
      function()
        vim.ui.input({ prompt = 'Condition: ' }, function(condition)
          if condition then
            require('dap').set_breakpoint(condition)
          end
        end)
      end,
      desc = 'DAP: Conditional Breakpoint (S-F9)',
    },
    {
      '<leader>d0',
      function()
        vim.ui.input({
          prompt = 'Hit condition: ',
        }, function(hit_condition)
          if hit_condition then
            require('dap').set_breakpoint(nil, hit_condition)
          end
        end)
      end,
      desc = 'DAP: Hit condition',
    },
    {
      '<leader>dl',
      function()
        vim.ui.input({ prompt = 'Log message {foo}: ' }, function(message)
          if message then
            require('dap').set_breakpoint(nil, nil, message)
          end
        end)
      end,
      desc = 'DAP: Log Point',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'DAP: Step Into',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'DAP: Step Over',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = 'DAP: Step Out',
    },
    {
      '<leader>dq',
      function()
        require('dap').close()
      end,
      desc = 'DAP: Close Session',
    },
    {
      '<leader>dQ',
      function()
        require('dap').terminate()
      end,
      desc = 'DAP: Terminate Session',
    },
    {
      '<leader>dD',
      function()
        require('dap').disconnect { terminateDebuggee = false }
      end,
      desc = 'DAP: Disconnect adapter',
    },
    {
      '<leader>dp',
      function()
        require('dap').pause()
      end,
      desc = 'DAP: Pause',
    },
    {
      '<leader>dr',
      function()
        require('dap').restart_frame()
      end,
      desc = 'DAP: Restart',
    },
    {
      '<leader>dR',
      function()
        require('dap').repl.open({ wrap = false }, 'tabnew')
        vim.cmd.tabnext() -- https://github.com/mfussenegger/nvim-dap/issues/756#issuecomment-1312684460
      end,
      desc = 'DAP: Toggle REPL',
    },
    {
      '<leader>dS',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'DAP: Run To Cursor',
    },
    {
      '<leader>dd',
      function()
        require('dap').focus_frame()
      end,
      desc = 'DAP: Focus frame',
    },
    {
      '<leader>dh',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = 'DAP: Debugger Hover',
    },
    {
      '<leader>ds',
      function()
        local ui = require 'dap.ui.widgets'
        ui.centered_float(ui.scopes, { number = true, wrap = false, width = 999 })
      end,
      desc = 'DAP: Toggle "scopes" in floating window',
    },
    {
      ---https://github.com/mfussenegger/nvim-dap/issues/1288#issuecomment-2248506225
      '<leader>da',
      function()
        local ui = require 'dap.ui.widgets'
        ui.centered_float(ui.sessions, { number = true, wrap = false, width = 999 })
      end,
      desc = 'DAP: Toggle "sessions" in floating window',
    },
  },

  config = function()
    -- require('dap-vscode-js').setup {
    --   node_path = 'node',
    --   -- debugger_path = os.getenv 'HOME' .. '/.DAP/vscode-js-debug',
    --   debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),
    --   adapters = { 'pwa-node', 'node' },
    -- }

    -- chrome debug adapter
    require('dap').adapters['chrome'] = {
      type = 'executable',
      command = 'node',
      args = { os.getenv 'HOME' .. '/.DAP/vscode-chrome-debug/out/src/chromeDebug.js' },
    }
    require('dap').adapters['pwa-chrome'] = {
      type = 'executable',
      command = 'node',
      args = { os.getenv 'HOME' .. '/.DAP/vscode-chrome-debug/out/src/chromeDebug.js' },
    }

    -- node debug adapter
    -- require('dap').adapters['pwa-node'] = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     command = 'node',
    --     args = { os.getenv 'HOME' .. '/.DAP/js-debug/src/dapDebugServer.js', '${port}' },
    --   },
    -- }
    -- require('dap').adapters['node'] = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     command = 'node',
    --     args = { os.getenv 'HOME' .. '/.DAP/js-debug/src/dapDebugServer.js', '${port}' },
    --   },
    -- }

    local js_based_languages = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

    local dap = require 'dap'

    for _, ext in ipairs(js_based_languages) do
      dap.configurations[ext] = {
        -- next client
        {
          name = 'Next.js: debug client-side',
          type = 'chrome',
          request = 'launch',
          url = 'http://localhost:3091',
          webRoot = '${workspaceFolder}',
          sourceMaps = true, -- https://github.com/vercel/next.js/issues/56702#issuecomment-1913443304
          runtimeArgs = { '-r', '--experimental-modules', '--preserve-symlinks' },
          skipFiles = { '<node_internals>/**' },
          program = '${workspaceFolder}/node_modules/.bin/next',
          sourceMapPathOverrides = {
            ['webpack://_N_E/*'] = '${webRoot}/*',
          },
        },
        -- next server
        {
          name = 'Next.js: debug server-side',
          type = 'pwa-node',
          request = 'attach',
          port = 9231,
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
          cwd = '${workspaceFolder}',
        },

        -- {
        --   name = 'Node: Attach to process',
        --   type = 'node',
        --   request = 'attach',
        --   port = 9229,
        --   runtimeExecutable = 'node',
        --   url = 'http://localhost:3000',
        --   skipFiles = {
        --     '<node_internals>/**',
        --     '${workspaceFolder}/node_modules/**',
        --   },
        -- },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          port = 9229,
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          -- cwd = '${workspaceFolder}',
          sourceMaps = true,
          -- skipFiles = {
          --   '<node_internals>/**',
          --   '${workspaceFolder}/node_modules/**',
          --   '${workspaceFolder}/.dist/**',
          -- },
        },
        -- {
        --   type = 'pwa-node',
        --   request = 'launch',
        --   name = 'Debug Jest Tests - "Ensure you have jest as your dependencies" (Node)',
        --   -- trace = true, -- include debugger info
        --   runtimeExecutable = 'node',
        --   runtimeArgs = {
        --     './node_modules/jest/bin/jest.js',
        --     '--runInBand',
        --   },
        --   rootPath = '${workspaceFolder}',
        --   cwd = '${workspaceFolder}',
        --   console = 'integratedTerminal',
        --   internalConsoleOptions = 'neverOpen',
        -- },
      }
    end
  end,
}