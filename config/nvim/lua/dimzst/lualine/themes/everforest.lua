-- =============================================================================
-- Genarated by lightline to lualine theme converter
--   https://gist.github.com/shadmansaleh/000871c9a608a012721c6acc6d7a19b9
-- License: MIT License
-- =============================================================================
local colors = {
  color10  = "#83c092",
  color9   = "#d3c6aa",
  color0   = "#9aa79d",
  color1   = "#4a555b",
  color2   = "#859289",
  color3   = "#374247",
  color4   = "#2f383e",
  color5   = "#e69875",
  color6   = "#a7c080",
  color7   = "#d699b6",
  color8   = "#e67e80",
}

local everforest = {
  replace = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color5 , gui = "bold", },
  },
  normal = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color6 , gui = "bold", },
  },
  inactive = {
    b = { fg = colors.color2, bg = colors.color3 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color2, bg = colors.color3 , gui = "bold", },
  },
  terminal = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color7 , gui = "bold", },
  },
  visual = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color8 , gui = "bold", },
  },
  insert = {
    b = { fg = colors.color9, bg = colors.color1 },
    c = { fg = colors.color9, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color9 , gui = "bold", },
  },
  command = {
    b = { fg = colors.color0, bg = colors.color1 },
    c = { fg = colors.color2, bg = colors.color3 },
    a = { fg = colors.color4, bg = colors.color10 , gui = "bold", },
  },
}

return everforest