return function (client, bufno)
  client.server_capabilities.semanticTokensProvider = nil
  local opts = { noremap = true, silent = true, buffer = bufno }
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<C-e>', vim.diagnostic.open_float, opts)
end