-- oil.nvim: ファイル操作（現在無効化中）
return {
  "stevearc/oil.nvim",
  enabled = false,  -- neo-tree に移行したため無効化
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local detail = false
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = false,
      },
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
    })
    
    -- oil.nvimを開く
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "File explorer" })
  end,
}

