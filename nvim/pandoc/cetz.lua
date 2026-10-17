-- Pandoc filter: ```cetz code blocks -> CeTZ figures.
-- Typst output (pandoc --pdf-engine=typst) gets the figure inlined as native Typst;
-- every other format gets an SVG compiled by `typst` and stored in the mediabag
-- (use --embed-resources for HTML).

local CETZ = "@preview/cetz:0.5.2"
local PLOT = "@preview/cetz-plot:0.1.4"

local function wrap(body)
  return ([[
#align(center, {
  import "%s"
  import "%s": plot
  cetz.canvas({
    import cetz.draw: *
%s
  })
})]]):format(CETZ, PLOT, body)
end

function CodeBlock(el)
  if not el.classes:includes("cetz") then
    return nil
  end
  local src = wrap(el.text)
  if FORMAT == "typst" then
    return pandoc.RawBlock("typst", src)
  end
  local page = "#set page(width: auto, height: auto, margin: 4pt, fill: none)\n"
  local svg = pandoc.pipe("typst", { "compile", "-f", "svg", "-", "-" }, page .. src)
  local name = pandoc.sha1(svg) .. ".svg"
  pandoc.mediabag.insert(name, "image/svg+xml", svg)
  return pandoc.Div({ pandoc.Para({ pandoc.Image({}, name) }) }, { style = "text-align: center" })
end
