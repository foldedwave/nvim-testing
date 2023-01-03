-- Shorten access to keymap
local keymap = vim.api.nvim_set_keymap

-- Space as leader key
keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("which-key").setup({});
local wk = require("which-key")
wk.register({
    ["<C-h>"] = { "<C-w>h", "navigate left" },
    ["<C-j>"] = { "<C-w>j", "navigate down" },
    ["<C-k>"] = { "<C-w>k", "navigate up" },
    ["<C-l>"] = { "<C-w>l", "navigate right" },
})
