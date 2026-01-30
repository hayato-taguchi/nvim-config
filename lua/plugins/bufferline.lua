-- bufferline.nvim: タブ風バッファ表示
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        themable = true,
        numbers = "none",
        close_command = function(bufnr)
          -- 最後のバッファなら空のバッファを作成してから閉じる
          local bufs = vim.fn.getbufinfo({ buflisted = 1 })
          if #bufs <= 1 then
            vim.cmd("enew")
          end
          vim.cmd("bdelete! " .. bufnr)
        end,
        right_mouse_command = "bdelete! %d",
        indicator = {
          style = "icon",
          icon = "▎",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thin",
        always_show_bufferline = true,
      },
    })

    -- バッファを安全に閉じる関数（閉じる前に必ず別バッファに切り替える）
    local function close_buffer()
      local to_close = vim.api.nvim_get_current_buf()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })
      local cur_win = vim.api.nvim_get_current_win()

      if #bufs <= 1 then
        -- 最後の1つなら空バッファを明示的に作成して現在ウィンドウに割り当てる
        local new_buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(cur_win, new_buf)
      else
        -- 他にバッファがあればそちらに切り替えてから閉じる
        vim.cmd("bnext")
      end
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(to_close) then
          vim.cmd("bdelete! " .. to_close)
        end
      end)
    end

    -- キーマップ
    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin buffer" })
    vim.keymap.set("n", "<leader>bx", close_buffer, { desc = "Close buffer" })
    vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
  end,
}

