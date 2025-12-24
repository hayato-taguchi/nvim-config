-- no-neck-pain.nvim: エディタを中央に配置
return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  config = function()
    require("no-neck-pain").setup({
      width = 100,
      autocmds = {
        enableOnVimEnter = true,  -- 起動時に自動でオン
      },
      buffers = {
        right = {
          enabled = true,
        },
        left = {
          enabled = true,
        },
        colors = {
          blend = -0.1,  -- 少し暗くする
        },
      },
    })
    
    -- トグル用キーマップ
    vim.keymap.set("n", "<leader>nn", "<cmd>NoNeckPain<cr>", { desc = "Toggle No Neck Pain" })
  end,
}

