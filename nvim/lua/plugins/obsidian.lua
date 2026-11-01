-- Markdown notes vault (obsidian.nvim community fork)
local vault = "~/.obsidian_notes"
local vault_md = vim.fn.expand(vault) .. "/*.md" -- in autocmd patterns `*` also matches `/`, so subfolders too

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- latest release, as the README recommends
  -- setup takes ~20ms (mostly the vault cache), so load it only for vault notes, :Obsidian and the keys below
  cmd = "Obsidian",
  event = { "BufReadPre " .. vault_md, "BufNewFile " .. vault_md },
  dependencies = { "ibhagwan/fzf-lua" }, -- obsidian only uses fzf-lua if it is already loaded
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
    -- markview renders markdown. obsidian.nvim only skips its own UI if markview is already on the
    -- runtimepath when it sets up, and the startup load order of the two varies, so turn it off here.
    ui = { enable = false },
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
