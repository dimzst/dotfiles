require("luasnip.loaders.from_vscode").lazy_load({})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/dimzst/snippet/*.lua", true)) do
  loadfile(ft_path)()
end
