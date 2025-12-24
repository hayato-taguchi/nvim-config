-- conform.nvim: コードフォーマッター
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "black" },
      },
      -- 保存時に自動フォーマット
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    })
    
    -- 手動フォーマット用キーマップ
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      })
    end, { desc = "Format file or range" })
  end,
}

