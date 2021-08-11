-- =============================================================================
-- Genarated by lightline to lualine theme converter
--   https://gist.github.com/shadmansaleh/000871c9a608a012721c6acc6d7a19b9
-- License: MIT License
-- =============================================================================
local colors = {
  color1   = "#5d677a",
  color2   = "#e06c75",
  color3   = "#313640",
  color4   = "#282c34",
  color5   = "#98c379",
  color6   = "#e5c07b",
  color7   = "#61afef",
  color0   = "#dcdfe4",
}

local onehalfdark = {
  replace = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color2 , gui = "bold", },
  },
  normal = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color5, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color5 , gui = "bold", },
  },
  inactive = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color0, bg = colors.color3 },
    a = { fg = colors.color0, bg = colors.color1 , gui = "bold", },
  },
  visual = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color6, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color6 , gui = "bold", },
  },
  insert = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color7, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color7 , gui = "bold", },
  },
}

return onehalfdark