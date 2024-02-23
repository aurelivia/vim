
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

local system = vim.loop.os_uname().sysname

require('lazy').setup('plugins', {
	change_detection = {
		enabled = false
	}
})

if vim.g.dotvim == nil then
	error('No dotvim defined')
end

if system:find('Windows') then
	vim.cmd('source ' .. vim.g.dotvim .. '.winrc')
else
	vim.cmd('source ' .. vim.g.dotvim .. '.vimrc')
end

require('lsp')