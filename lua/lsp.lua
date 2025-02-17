
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { noremap = true, silent = true }

local on_attach = require('lsp-onattach')

-- local chars = {}
--
-- vim.api.nvim_create_user_command('Asdf', function ()
--   print(vim.inspect(chars))
-- end, {})
--
-- vim.api.nvim_create_autocmd('LspTokenUpdate', {
--   callback = function (args)
--     local token = args.data.token
--     if token.type == 'variable' then
--       local char = vim.fn.getline(token.line):sub(token.start_col + 1, token.start_col + 1)
--       if (char:match('%u')) then
--         -- table.insert(chars, vim.fn.getline(token.line):sub(token.start_col + 1, token.end_col + 1))
--         vim.lsp.semantic_tokens.highlight_token(
--           token, args.buf, args.data.client_id, '@lsp.type.type'
--         )
--       end
--     end
--   end
-- })

-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- delay update diagnostics
--     update_in_insert = false,
--   }
-- )

if vim.fn.executable('typescript-language-server') == 1 then
  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    -- root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
    root_dir = function (path)
      local denoPath = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')(path)
      if denoPath then return end
      return lspconfig.util.root_pattern('tsconfig.json')(path)
        or lspconfig.util.root_pattern('package.json', 'jsconfig.json', '.git')(path)
    end,
    settings = {
      typescript = {
        format = {
          enable = false,
          trimTrailingWhitespace = false
        }
      },
      diagnostics = {
        ignoredCodes = {
          2350, -- Only void function can be called with new
          7043, 7044, 7045, 7056, 7047, 7048, 7049, 7050, -- Implicit any warnings
          2365 -- Operator can't be applied to types
        }
      }
    }
  })
end

-- lspconfig.denols.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
--   init_options = {
--     enable = true,
--     unstable = false,
--     lint = false
--   }
-- })

vim.g.markdown_fenced_languages = {
  'ts=typescript'
}

if vim.fn.executable('pyright-langserver') == 1 then
  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

if vim.fn.executable('csharp-ls') == 1 then
  lspconfig.csharp_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

-- if vim.fn.executable('rust-analyzer') == 1 then
--   lspconfig.rust_analyzer.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = function (path)
--       return lspconfig.util.root_pattern('Cargo.toml', '.git')(path)
--     end
--   })
-- end

if vim.fn.executable('clangd') == 1 then
  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

if vim.fn.executable('haskell-language-server-wrapper') == 1 then
  lspconfig.hls.setup({
    on_attach = on_attach,
    capabilities = capabilites
  })
end

if vim.fn.executable('zls') == 1 then
  lspconfig.zls.setup({
    on_attach = on_attach,
    capabilities = capabilites,
    settings = {
      zls = {
        enable_build_on_save = false
      }
    }
  })

  vim.g.zig_fmt_parse_errors = 0
  vim.g.zig_fmt_autosave = 0
end