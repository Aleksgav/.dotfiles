return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  keys = {
    { "<leader>gg", function() require("neogit").open({ cwd = LazyVim.root.git() }) end, desc = "Neogit (Root Dir)" },
    { "<leader>gG", "<cmd>Neogit<cr>", desc = "Neogit (cwd)" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },

    -- Only one of these is needed.
    -- "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
    -- "echasnovski/mini.pick", -- optional
    -- "folke/snacks.nvim", -- optional
  },
}
