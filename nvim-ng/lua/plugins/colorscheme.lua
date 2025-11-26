return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        transparent = true,
        overrides = function(colors)
          return {
            -- update kanagawa to handle new treesitter highlight captures
            ["@string.regexp"] = { link = "@string.regex" },
            ["@variable.parameter"] = { link = "@parameter" },
            ["@exception"] = { link = "@exception" },
            ["@string.special.symbol"] = { link = "@symbol" },
            ["@markup.strong"] = { link = "@text.strong" },
            ["@markup.italic"] = { link = "@text.emphasis" },
            ["@markup.heading"] = { link = "@text.title" },
            ["@markup.raw"] = { link = "@text.literal" },
            ["@markup.quote"] = { link = "@text.quote" },
            ["@markup.math"] = { link = "@text.math" },
            ["@markup.environment"] = { link = "@text.environment" },
            ["@markup.environment.name"] = { link = "@text.environment.name" },
            ["@markup.link.url"] = { link = "Special" },
            ["@markup.link.label"] = { link = "Identifier" },
            ["@comment.note"] = { link = "@text.note" },
            ["@comment.todo"] = { link = "@text.todo" },
            ["@comment.warning"] = { link = "@text.warning" },
            ["@comment.danger"] = { link = "@text.danger" },
            ["@diff.plus"] = { link = "@text.diff.add" },
            ["@diff.minus"] = { link = "@text.diff.delete" },
          }
        end,
      })
    end,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized-osaka",
      -- colorscheme = "kanagawa",
    },
  },
}
