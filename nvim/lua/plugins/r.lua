-- cmp-r is deprecated: R.nvim now ships a built-in language server.
-- LazyVim's lang.r extra still pulls it in for nvim-cmp; disable it.
return {
  { "R-nvim/cmp-r", enabled = false },
}
