-- nvim-treesitter: シンタックスハイライトとフォールド
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "javascript",
        "typescript",
        "lua",
        "bash",
        "json",
        "yaml",
        "markdown",
        "html",
        "css",
        "dockerfile",
        "gitignore",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,  -- catppuccinとの互換性のため
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}

