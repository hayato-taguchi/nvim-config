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
        mason = true,
        cmp = true,
        native_lsp = {
          enabled = true,
        },
        telescope = {
          enabled = true,
        },
        which_key = true,
        lsp_trouble = true,
        noice = true,
      },
      term_colors = true
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

