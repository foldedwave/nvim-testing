require("options")
require("plugins").setup()
vim.opt.runtimepath:append("/root/neotest/")
vim.opt.runtimepath:append("/root/neotest-dotnet/")
require("keymaps")
require("config/neotest-config")
