-- Lazygit runs through Snacks; moved off <leader>gg/gG, which Neogit uses.
return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>gz", function() Snacks.lazygit({ cwd = LazyVim.root.git() }) end, desc = "Lazygit (Root Dir)" },
    { "<leader>gZ", function() Snacks.lazygit() end, desc = "Lazygit (cwd)" },
  },
}
