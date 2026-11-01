-- Name the zellij tab that holds this nvim after the project folder (cwd),
-- follow :cd / project switches, and put the tab's previous name back on exit.
if not (vim.env.ZELLIJ and vim.env.ZELLIJ_PANE_ID) or #vim.api.nvim_list_uis() == 0 then
  return
end

local pane_id = tonumber(vim.env.ZELLIJ_PANE_ID)
local tab_id, old_name

local function rename(name)
  if tab_id and name ~= "" then
    vim.system({ "zellij", "action", "rename-tab", "--tab-id", tostring(tab_id), name })
  end
end

local function project_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

-- find our own tab (stable id + current name) from our pane id
vim.system({ "zellij", "action", "list-panes", "--json", "--tab" }, { text = true }, function(res)
  if res.code ~= 0 then
    return
  end
  local ok, panes = pcall(vim.json.decode, res.stdout)
  if not ok then
    return
  end
  for _, p in ipairs(panes) do
    if p.id == pane_id and not p.is_plugin then
      tab_id, old_name = p.tab_id, p.tab_name
      break
    end
  end
  vim.schedule(function()
    rename(project_name())
  end)
end)

local group = vim.api.nvim_create_augroup("zellij_tab_name", { clear = true })

vim.api.nvim_create_autocmd("DirChanged", {
  group = group,
  callback = function()
    rename(project_name())
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    if tab_id and old_name then
      -- wait briefly so the rename isn't lost when nvim exits
      vim.system({ "zellij", "action", "rename-tab", "--tab-id", tostring(tab_id), old_name }):wait(1000)
    end
  end,
})
