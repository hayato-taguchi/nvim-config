-- Git関連プラグイン
return {
  -- gitsigns.nvim: Git差分をインライン表示
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          -- ナビゲーション
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, buffer=bufnr, desc="Next hunk"})
          
          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, buffer=bufnr, desc="Previous hunk"})
          
          -- アクション
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {buffer=bufnr, desc="Stage hunk"})
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {buffer=bufnr, desc="Reset hunk"})
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, {buffer=bufnr, desc="Undo stage hunk"})
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {buffer=bufnr, desc="Preview hunk"})
          vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {buffer=bufnr, desc="Blame line"})
          vim.keymap.set('n', '<leader>hd', gs.diffthis, {buffer=bufnr, desc="Diff this"})
        end
      })
    end,
  },
  
  -- lazygit.nvim: LazyGit統合
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
  
  -- diffview.nvim: Git差分表示
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("diffview").setup({
        -- デフォルト設定を使用
      })
      
      -- キーマッピング
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open diffview" })
      vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" })
      vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", { desc = "File history" })
    end,
  },
}

