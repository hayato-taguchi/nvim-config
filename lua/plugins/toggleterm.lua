-- toggleterm.nvim: ターミナル管理
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<leader>t]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'horizontal',  -- 下部ターミナル
      close_on_exit = true,
    })

    -- Lazygit（フロート表示）
    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.9),
      },
    })

    function _G.toggle_lazygit()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>gg", "<cmd>lua toggle_lazygit()<CR>", { desc = "Toggle Lazygit" })

    -- ============================================================
    -- エージェントパネル（Neovim ネイティブターミナル・右側垂直分割）
    -- ============================================================
    local agent_buf = nil
    local agent_win = nil
    local agent_initialized = false

    local function get_agent_win()
      -- エージェントパネルのウィンドウが開いているか確認
      if agent_win and vim.api.nvim_win_is_valid(agent_win) then
        return agent_win
      end
      return nil
    end

    local function open_agent_panel()
      -- 既存のバッファがあれば再利用
      if agent_buf and vim.api.nvim_buf_is_valid(agent_buf) then
        -- 右側に垂直分割でウィンドウを開く
        vim.cmd("botright vsplit")
        agent_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(agent_win, agent_buf)
        -- 幅を40%に設定
        local width = math.floor(vim.o.columns * 0.4)
        vim.api.nvim_win_set_width(agent_win, width)
        vim.cmd("startinsert")
      else
        -- 新規作成
        vim.cmd("botright vsplit")
        agent_win = vim.api.nvim_get_current_win()
        -- 幅を40%に設定
        local width = math.floor(vim.o.columns * 0.4)
        vim.api.nvim_win_set_width(agent_win, width)
        vim.cmd("terminal")
        agent_buf = vim.api.nvim_get_current_buf()
        vim.cmd("startinsert")

        -- 初回のみ cursor-agent を起動
        if not agent_initialized then
          agent_initialized = true
          vim.defer_fn(function()
            if vim.api.nvim_buf_is_valid(agent_buf) then
              local chan = vim.b[agent_buf].terminal_job_id
              if chan then
                vim.fn.chansend(chan, "cursor-agent\n")
              end
            end
          end, 200)
        end
      end
    end

    local function close_agent_panel()
      if agent_win and vim.api.nvim_win_is_valid(agent_win) then
        vim.api.nvim_win_hide(agent_win)
        agent_win = nil
      end
    end

    function _G.toggle_agent_panel()
      if get_agent_win() then
        close_agent_panel()
      else
        open_agent_panel()
      end
    end

    vim.keymap.set("n", "<leader>a", "<cmd>lua toggle_agent_panel()<CR>", { desc = "Toggle Agent Panel" })

    -- ターミナルウィンドウのキーマッピング
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}

