-- Markdown notes vault (obsidian.nvim community fork)
local vault = "~/.obsidian_notes"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- latest release, as the README recommends
  lazy = false, -- `keys` would otherwise make lazy.nvim lazy-load it; vault notes need it loaded
  keys = {
    { "<leader>zn", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>zf", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
    { "<leader>zs", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>zt", "<cmd>Obsidian today<cr>", desc = "Today's note" },
    { "<leader>zb", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- silence the 3.x deprecation warning
    workspaces = { { name = "notes", path = vault } },
    picker = { name = "fzf-lua" },
    -- file name from the title, not a timestamp (wrapped so the require runs after the plugin loads)
    note_id_func = function(title, dir)
      return require("obsidian.builtin").title_id(title, dir)
    end,
    -- vault index (aliases in quick switch, faster lookups); kept in ~/.cache/nvim, rebuilt per machine
    cache = { enabled = true },
  },
  init = function()
    -- obsidian.nvim errors at startup if the vault folder is missing (e.g. on a fresh machine)
    vim.fn.mkdir(vim.fn.expand(vault), "p")
  end,
}
