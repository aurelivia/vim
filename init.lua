local system = vim.loop.os_uname().sysname

if system:find('Windows') then
  if vim.g.msys == nil then
    vim.g.msys = 'C:\\MSYS'
    vim.env.PATH = vim.env.PATH .. vim.g.msys .. '\\usr\\local\\bin;' .. vim.g.msys .. '\\usr\\bin;' .. vim.g.msys .. '\\bin;' .. vim.g.msys .. '\\opt\\bin'
  end
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  change_detection = {
    enabled = false
  }
})

if vim.g.dotvim == nil then
  error('No dotvim defined')
end


if system:find('Windows') then
  if vim.g.winrc == nil then
    vim.g.winrc = vim.g.dotvim .. '.winrc'
  end
  vim.cmd('source ' .. vim.g.winrc)
else
  if vim.g.vimrc == nil then
    vim.g.vimrc = vim.g.dotvim .. '.vimrc'
  end
  vim.cmd('source ' .. vim.g.vimrc)
end

require('lsp')