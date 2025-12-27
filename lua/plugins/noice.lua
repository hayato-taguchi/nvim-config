-- noice.nvim: モダンなUI（コマンドライン、メッセージ、通知）
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- LSPのhoverやsignature helpをnoiceで表示
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- 検索を下部に表示
        command_palette = true,       -- コマンドパレット風
        long_message_to_split = true, -- 長いメッセージを分割
        inc_rename = false,           -- inc-renameは使わない
        lsp_doc_border = true,        -- LSPドキュメントにボーダー
      },
      routes = {
        -- 特定のメッセージを非表示
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    })
    
    -- nvim-notifyの設定
    require("notify").setup({
      background_colour = "#000000",
      timeout = 3000,
      max_width = 80,
      render = "compact",
      stages = "fade",
    })
    
    -- キーマップ
    vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss notifications" })
  end,
}



