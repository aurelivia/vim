return {
  {
    dir = vim.g.dotvim,
    lazy = false,
    priority = 1000
  },
  {
    'vim-airline/vim-airline',
    lazy = false,
    priority = 999,
    config = function ()
      vim.g.airline_theme = 'onedark'
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline#extensions#tabline#fnamemod'] = ':t'
      vim.g['airline#extensions#whitespace#mixed_indent_algo'] = 2
      vim.g['airline#extensions#whitespace#checks'] = { 'indent', 'trailing', 'long', 'conflicts' }
    end
  },
  { 'svermeulen/vimpeccable', lazy = false },
  'mhinz/vim-sayonara',
  {
    'justinmk/vim-dirvish',
    config = function ()
      vim.cmd([[
        nm <C-d> <Plug>(dirvish_up)
        augroup dirvishBindings
          autocmd!
          autocmd FileType dirvish nmap <nowait><buffer> j <Plug>(dirvish_up)
          autocmd FileType dirvish nmap <nowait><buffer> <Left> <Plug>(dirvish_up)
          autocmd FileType dirvish nmap <nowait><buffer> k gj
          autocmd FileType dirvish nmap <nowait><buffer> K 10gj
          autocmd FileType dirvish nmap <nowait><buffer> l gk
          autocmd FileType dirvish nmap <nowait><buffer> ; <CR>
          autocmd FileType dirvish nmap <nowait><buffer> <Right> <CR>
          autocmd FileType dirvish nmap <nowait><buffer> <C-d> <Plug>(dirvish_quit)

          autocmd FileType dirvish nmap <nowait><buffer> <kDivide> <Plug>(dirvish_up)
          autocmd FileType dirvish nmap <nowait><buffer> <kMultiply> <CR>
        augroup END
      ]])
    end
  },
  { 'chaoren/vim-wordmotion', lazy = false },
  'tomtom/tcomment_vim',
  'ntpeters/vim-better-whitespace',
  'tpope/vim-surround',
  'tpope/vim-eunuch',
  'junegunn/vim-easy-align',
  { 'gerw/vim-HiLinkTrace', cmd = 'HLT' },
  'chrisbra/unicode.vim',
  'neovim/nvim-lspconfig',
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'
    },
    config = function ()
      local cmp = require('cmp')

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      cmp.setup({
        completion = {
          autocomplete = false
        },
        snippet = {
          expand = function (args)
            vim.fn['vsnip#anonymous'](args.body)
          end
        },
        mapping = {
          ['<S-Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
              feedkey('<Plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i' }),
          ['<Down>'] = { i = cmp.mapping.select_next_item() },
          ['<Up>'] = { i = cmp.mapping.select_prev_item() },
          ['<ESC>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.abort()
              cmp.core:reset()
            else
              fallback()
            end
          end, { 'i' }),
          ['<Space>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              if cmp.get_selected_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }, fallback)
              else
                cmp.close()
                cmp.core:reset()
                fallback()
              end
            else
              fallback()
            end
          end, { 'i' })
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }
        }, {
          { name = 'buffer' }
        })
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = 'nvim-lua/plenary.nvim'
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    dependencies = 'nvim-lua/plenary.nvim',
    ft = 'markdown',
    opts = {
      completions = {
        nvim_cmp = true
      },
      picker = {
        name = 'telescope.nvim'
      },
      workspaces = {
        { name = 'Language', path = '~/.drive/Lingua' }
      }
    }
  }
}