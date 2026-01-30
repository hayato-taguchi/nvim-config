-- neo-tree.nvim: ファイルツリー
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,  -- 最後のウィンドウなら閉じる
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      source_selector = {
        winbar = true,  -- ソース切り替えタブを表示
        sources = {
          { source = "filesystem", display_name = " Files" },
          { source = "buffers", display_name = " Buffers" },
          { source = "git_status", display_name = " Git" },
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
      window = {
        position = "left",
        width = 35,
        mappings = {
          ["<space>"] = "none",  -- leader キーと競合しないように
          ["<cr>"] = "open",
          ["o"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            "node_modules",
          },
        },
        follow_current_file = {
          enabled = true,  -- 現在のファイルを追従
        },
        use_libuv_file_watcher = true,  -- ファイル変更を監視
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
      git_status = {
        window = {
          position = "left",
        },
      },
    })

    -- キーマッピング
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })
    vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
  end,
}
