-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "<leader>P", "<CMD>NeovimProjectHistory<CR>", { desc = "Open project history" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
-- keymap.set("n", "-", "<C-x>")

-- Delete a word backward
-- keymap.set("n", "dw", "vb_d")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
--keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
-- keymap.set("n", "sh", "<C-w>h")
-- keymap.set("n", "sk", "<C-w>k")
-- keymap.set("n", "sj", "<C-w>j")
-- keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, opts)
keymap.set("n", "<C-k>", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, opts)

-- AI: insert at cursor (claude -p on the Claude subscription; no tools, text only)
local ai_ns = vim.api.nvim_create_namespace("ai_insert")
local ai_system = table.concat({
  "You write text that is inserted directly into the user's file in a text editor.",
  "Output ONLY the exact text to insert: no explanations, no commentary, and no code fence around it",
  "unless the inserted text itself should be a fenced block (e.g. a code block inside a markdown document).",
  "Match the surrounding indentation and style.",
  "In markdown, figures are ```cetz fenced blocks: the body is a CeTZ 0.5.2 canvas body with `cetz.draw.*`",
  "and cetz-plot 0.1.4 `plot` already imported (do not import anything).",
  "Math is TeX: $...$ inline, $$...$$ display.",
}, " ")

keymap.set("n", "<leader>ai", function()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  vim.ui.input({ prompt = "AI: " }, function(req)
    if not req or req == "" then
      return
    end
    -- extmark keeps the insert point right if lines above change while waiting
    local mark = vim.api.nvim_buf_set_extmark(buf, ai_ns, row, 0, {})
    local file = vim.api.nvim_buf_get_name(buf)
    local prompt = table.concat({
      ("File: %s (filetype: %s)"):format(vim.fn.fnamemodify(file, ":t"), vim.bo[buf].filetype),
      ("Cursor is on line %d; your output is inserted below it."):format(row + 1),
      "<file>",
      table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n"),
      "</file>",
      "Request: " .. req,
    }, "\n")
    local cmd = {
      "claude",
      "-p",
      "--tools",
      "",
      "--no-session-persistence",
      "--output-format",
      "text",
      "--append-system-prompt",
      ai_system,
    }
    local cwd = file ~= "" and vim.fn.fnamemodify(file, ":h") or nil
    vim.notify("AI: working…")
    vim.system(cmd, { stdin = prompt, text = true, cwd = cwd }, function(res)
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        local pos = vim.api.nvim_buf_get_extmark_by_id(buf, ai_ns, mark, {})
        vim.api.nvim_buf_del_extmark(buf, ai_ns, mark)
        if res.code ~= 0 then
          vim.notify(res.stderr, vim.log.levels.ERROR, { title = "claude" })
          return
        end
        local text = (res.stdout:gsub("^\n+", ""):gsub("%s+$", ""))
        if text == "" then
          vim.notify("AI: empty response", vim.log.levels.WARN)
          return
        end
        vim.api.nvim_buf_set_lines(buf, pos[1] + 1, pos[1] + 1, false, vim.split(text, "\n"))
      end)
    end)
  end)
end, { desc = "AI: insert at cursor" })
