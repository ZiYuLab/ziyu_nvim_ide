-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.o.timeout = true
vim.o.timeoutlen = 300 -- 双击时间，单位是ms

vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Drop into NORMAL mode" })
