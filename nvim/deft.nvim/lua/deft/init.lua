-- Deft-style list of markdown notes (like Emacs Deft): `title --- snippet ...... YYYY-mm-dd HH:MM`, newest first.
-- Local plugin, spec + keys in lua/plugins/deft.lua. Picker is fzf-lua.
-- In the list: type to filter title/snippet/date, F4 toggles the preview, ctrl-g = live grep over the same notes.

local M = {}

local SNIPPET_CHARS = 300 -- snippet text to collect, enough for the widest row
local MAX_LINES = 60 -- lines read per note
local WIN_WIDTH = 0.90
local GUTTER = 5 -- columns fzf does not give to the rows: window border, pointer/marker, scrollbar
local DATE_FMT = "%Y-%m-%d %H:%M"

-- color `s` with the fg of a highlight group as 24-bit ANSI (plain 16-color codes showed no color in the picker)
local function ansi(group, s, bold)
  local fg = vim.api.nvim_get_hl(0, { name = group, link = false }).fg
  local codes = bold and { "1" } or {}
  if fg then
    codes[#codes + 1] = ("38;2;%d;%d;%d"):format(
      bit.rshift(fg, 16),
      bit.band(bit.rshift(fg, 8), 255),
      bit.band(fg, 255)
    )
  end
  return #codes > 0 and ("\27[%sm%s\27[0m"):format(table.concat(codes, ";"), s) or s
end

-- one line of plain text: no control characters (tabs would break the fzf fields), single spaces
local function clean(s)
  return vim.trim((s:gsub("%c", " "):gsub("%s+", " ")))
end

-- cut `s` to at most `width` display columns (Cyrillic and wide characters safe)
local function truncate(s, width)
  s = vim.fn.strcharpart(s, 0, width)
  while vim.fn.strdisplaywidth(s) > width do
    s = vim.fn.strcharpart(s, 0, vim.fn.strchars(s) - 1)
  end
  return s
end

-- title: frontmatter `title:`, else the first `# heading`, else the file name; snippet: the text after them
local function parse_note(file)
  local fh = io.open(file, "r")
  if not fh then
    return nil
  end
  local title, h1
  local parts, len, n = {}, 0, 0
  local in_frontmatter = false
  for line in fh:lines() do
    n = n + 1
    if n == 1 and line:match("^%-%-%-%s*$") then
      in_frontmatter = true
    elseif in_frontmatter then
      if line:match("^%-%-%-%s*$") or line:match("^%.%.%.%s*$") then
        in_frontmatter = false
      else
        local t = line:match("^title:%s*(.-)%s*$")
        if t and t ~= "" then
          title = t:gsub([[^(["'])(.*)%1$]], "%2")
        end
      end
    elseif not h1 and line:match("^#%s+%S") then
      h1 = line:match("^#%s+(.-)%s*$")
      title = title or h1
      if title ~= h1 then -- frontmatter title differs: keep the heading as text
        parts[#parts + 1] = line
      end
    elseif line:match("%S") then
      parts[#parts + 1] = line
      len = len + #line
    end
    if len >= SNIPPET_CHARS or n >= MAX_LINES then
      break
    end
  end
  fh:close()
  local stat = vim.uv.fs_stat(file)
  return {
    file = file,
    title = clean(title or vim.fn.fnamemodify(file, ":t:r")),
    snippet = clean(table.concat(parts, " ")),
    mtime = stat and stat.mtime.sec or 0,
  }
end

local function list_notes(dir)
  -- fd skips hidden dirs (.obsidian, .git) and .gitignore'd files
  local res = vim
    .system({ "fd", "--type", "f", "--extension", "md", "--absolute-path", ".", dir }, { text = true })
    :wait()
  if res.code ~= 0 then
    vim.notify("fd failed: " .. (res.stderr or ""), vim.log.levels.ERROR, { title = "Deft" })
    return nil
  end
  return vim.split(res.stdout, "\n", { trimempty = true })
end

-- fzf rows sized so the date sits at the right edge. Each row is `file:1:1:<TAB>display`: fzf shows only the
-- display field, and the `file:line:col:` prefix is the grep format fzf-lua's previewer and file actions parse
-- (a plain `file<TAB>display` row breaks them, they split it at the first `:` of e.g. the time).
local function make_rows(notes, width)
  local date_w = #os.date(DATE_FMT, 0)
  local rows = {}
  for _, note in ipairs(notes) do
    local title = truncate(note.title, math.floor(width / 2))
    local left_w = vim.fn.strdisplaywidth(title) + 5 -- " --- "
    local snippet = truncate(note.snippet, math.max(0, width - left_w - date_w - 2))
    local pad = math.max(1, width - left_w - vim.fn.strdisplaywidth(snippet) - date_w)
    rows[#rows + 1] = ("%s:1:1:\t%s%s%s%s%s"):format(
      note.file,
      ansi("Constant", title, true), -- cyan in solarized-osaka
      ansi("Comment", " --- "),
      snippet,
      (" "):rep(pad),
      ansi("Function", os.date(DATE_FMT, note.mtime)) -- blue
    )
  end
  return rows
end

-- list the notes under `dir` (recursive)
function M.open(dir)
  dir = vim.fs.normalize(dir)
  local files = list_notes(dir)
  if not files then
    return
  end
  local notes = {}
  for _, file in ipairs(files) do
    notes[#notes + 1] = parse_note(file)
  end
  table.sort(notes, function(a, b)
    return a.mtime > b.mtime
  end)

  local fzf = require("fzf-lua")
  local file_actions = fzf.defaults.actions.files
  fzf.fzf_exec(make_rows(notes, math.floor(vim.o.columns * WIN_WIDTH) - GUTTER), {
    prompt = "Deft> ",
    winopts = {
      title = (" Deft: %s "):format(vim.fn.fnamemodify(dir, ":~")),
      width = WIN_WIDTH,
      height = 0.85,
      preview = { hidden = true, layout = "horizontal", horizontal = "right:45%" },
    },
    previewer = "builtin",
    fzf_opts = {
      ["--delimiter"] = "\t",
      ["--with-nth"] = "2..", -- hide the file path
      ["--tiebreak"] = "index", -- equal matches stay newest first
    },
    actions = {
      ["enter"] = file_actions["enter"],
      ["ctrl-s"] = file_actions["ctrl-s"],
      ["ctrl-v"] = file_actions["ctrl-v"],
      ["ctrl-t"] = file_actions["ctrl-t"],
      ["alt-q"] = file_actions["alt-q"],
      -- full-text search in the same notes; the default rg_opts end with `-e`, so the glob goes first
      ["ctrl-g"] = function(_, opts)
        fzf.live_grep({
          cwd = dir,
          search = opts.last_query or "",
          rg_opts = "--glob=*.md " .. fzf.config.globals.grep.rg_opts,
        })
      end,
    },
  })
end

-- list the notes under the current file's folder (:pwd if the buffer is not a file)
function M.open_file_dir()
  local file = vim.api.nvim_buf_get_name(0)
  -- a real file on disk → its folder; otherwise (dashboard, empty buffer, terminal, oil, help…) → :pwd
  local dir = vim.bo.buftype == "" and file ~= "" and vim.fn.fnamemodify(file, ":p:h") or vim.uv.cwd()
  if vim.fn.isdirectory(dir) == 0 then -- new unsaved file in a missing folder
    dir = vim.uv.cwd()
  end
  M.open(dir)
end

-- pick any folder under ~, then list its notes
function M.pick_folder()
  local home = vim.uv.os_homedir()
  require("fzf-lua").fzf_exec(
    ("fd --type d --hidden --exclude .git --exclude node_modules --base-directory %s ."):format(
      vim.fn.shellescape(home)
    ),
    {
      prompt = "Folder> ",
      winopts = { title = " Deft: pick a notes folder under ~ " },
      previewer = false,
      actions = {
        ["enter"] = function(selected)
          if selected[1] then
            M.open(vim.fs.joinpath(home, selected[1]))
          end
        end,
      },
    }
  )
end

return M
