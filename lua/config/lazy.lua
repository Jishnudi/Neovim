-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.fillchars = { eob = " " }

vim.opt.tabstop = 4      -- number of spaces a tab counts for
vim.opt.shiftwidth = 4   -- spaces used for autoindent
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.softtabstop = 4  -- spaces inserted when pressing Tab

-- vim.opt.termguicolors = true

-- Setup lazy.nvim
require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } }, {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    rocks = {
        hererocks = false,
    },
})

require("options")
