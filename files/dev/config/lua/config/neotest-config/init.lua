local neotest = require("neotest")

local lib = require("neotest.lib")
local DotnetNeotestAdapter = require("neotest-dotnet")
--DotnetNeotestAdapter.root = lib.files.match_root_pattern("*.sln", "*.csproj")

neotest.setup({
  log_level = vim.log.levels.DEBUG,
  adapters = {
    DotnetNeotestAdapter,
  },
})

require("which-key").setup({});
local wk = require("which-key")
wk.register({
    ["<leader>"] = {
        t = {
            name = "test",
            s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "toggle summary" },
            r = { "<cmd>lua require('neotest').run.run()<cr>", "run test" },
            f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "run tests in file" },
            a = { "<cmd>lua require('neotest').run.run({suite = true})<cr>", "run suite" },
            d = { "<cmd>lua require('neotest').run.attach()<cr>", "debug test" },
            o = { "<cmd>lua require('neotest').output.open()<cr>", "show test output" },
            p = { "<cmd>lua require('neotest').output_panel.open()<cr>", "show output panel" },
	},         
    },
})


