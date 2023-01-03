require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("which-key").setup {}
local wk = require("which-key")
wk.register({
    ["<leader>"] = {
        e = { "<cmd>NvimTreeToggle<cr>", "explore" },
    },
})
