-- catppuccin カラースキーム
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      integrations = {
        gitsigns = true,
        treesitter = true,
      },
      term_colors = true
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

