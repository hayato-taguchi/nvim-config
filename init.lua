-- ============================================================================
-- Neovim Configuration (VSCode Neovim & 通常のNeovim両対応)
-- ============================================================================

-- リーダーキーをスペースに設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本設定
vim.opt.clipboard = "unnamedplus"  -- システムクリップボードを使用
vim.opt.hlsearch = true            -- 検索ハイライトを有効化
vim.opt.ignorecase = true          -- 検索時に大文字小文字を区別しない
vim.opt.smartcase = true           -- 大文字が含まれている場合は区別する
vim.opt.timeoutlen = 500           -- キーマッピングのタイムアウト（ミリ秒）

-- VSCode環境かどうかで分岐
if vim.g.vscode then
  -- ============================================================================
  -- VSCode Neovim専用設定
  -- ============================================================================
  
  -- 注意: jjマッピングはsettings.jsonのcompositeKeysで設定すること
  -- "vscode-neovim.compositeKeys": { "jj": { "command": "vscode-neovim.escape" } }
  
  -- ファイル保存
  vim.keymap.set("n", "<leader>w", function()
    vim.fn.VSCodeNotify("workbench.action.files.save")
  end, { noremap = true, silent = true, desc = "Save file" })
  
  -- クイックオープン
  vim.keymap.set("n", "<leader>p", function()
    vim.fn.VSCodeNotify("workbench.action.quickOpen")
  end, { noremap = true, silent = true, desc = "Quick open" })
  
  -- エクスプローラー
  vim.keymap.set("n", "<leader>e", function()
    vim.fn.VSCodeNotify("workbench.view.explorer")
  end, { noremap = true, silent = true, desc = "Explorer" }) 
  
  -- ============================================================================
  -- スニペット（関数雛形）設定
  -- コマンドモードで :コマンド名 または :コマンド名/関数名 で展開
  -- 例: 
  --   :afn → async () => {}
  --   :afn/export → export async () => {}
  --   :afunc/handleDelete → async function handleDelete() {}
  --   :afunc/export/handleDelete → export async function handleDelete() {}
  --   :func/myFunction → function myFunction() {}
  --   :func/export/myFunction → export function myFunction() {}
  -- ============================================================================
  
  -- ヘルパー関数: 引数からexportフラグと関数名を抽出
  -- 形式: export/関数名, export, 関数名, 空
  local function parse_func_args(args)
    local input = (args.args or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if input == "" then
      return false, ""
    end
    
    -- export/関数名 の形式
    local export, name = input:match("^export/(.+)$")
    if export then
      return true, name:gsub("^%s+", ""):gsub("%s+$", "")
    end
    
    -- export だけの場合
    if input == "export" then
      return true, ""
    end
    
    -- 関数名だけの場合
    return false, input
  end
  
  -- ヘルパー関数: テキストを現在位置に挿入
  local function insert_text(text)
    vim.api.nvim_put(vim.split(text, "\n"), "c", true, true)
  end
  
  -- 非同期アロー関数: :afn または :afn/export
  vim.api.nvim_create_user_command("Afn", function(args)
    local is_export, _ = parse_func_args(args)
    local prefix = is_export and "export " or ""
    insert_text(prefix .. "async () => {\n\t\n}")
  end, { nargs = "?", desc = "Async arrow function" })
  
  -- アロー関数: :fn または :fn/export
  vim.api.nvim_create_user_command("Fn", function(args)
    local is_export, _ = parse_func_args(args)
    local prefix = is_export and "export " or ""
    insert_text(prefix .. "() => {\n\t\n}")
  end, { nargs = "?", desc = "Arrow function" })
  
  -- 名前付き非同期関数: :afunc または :afunc/handleDelete または :afunc/export/handleDelete
  vim.api.nvim_create_user_command("Afunc", function(args)
    local is_export, name = parse_func_args(args)
    local prefix = is_export and "export " or ""
    local func_name = name ~= "" and name or "name"
    insert_text(prefix .. "async function " .. func_name .. "() {\n\t\n}")
  end, { nargs = "?", desc = "Named async function" })
  
  -- 名前付き関数: :func または :func/myFunction または :func/export/myFunction
  vim.api.nvim_create_user_command("Func", function(args)
    local is_export, name = parse_func_args(args)
    local prefix = is_export and "export " or ""
    local func_name = name ~= "" and name or "name"
    insert_text(prefix .. "function " .. func_name .. "() {\n\t\n}")
  end, { nargs = "?", desc = "Named function" })
  
  -- console.log: :clog または :clog/variable
  vim.api.nvim_create_user_command("Clog", function(args)
    local content = (args.args or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if content ~= "" then
      insert_text("console.log(" .. content .. ")")
    else
      insert_text("console.log()")
    end
  end, { nargs = "?", desc = "Console log" })
  
  -- 小文字エイリアス（:afn, :fn, :afunc, :func, :clog で入力可能に）
  vim.cmd([[
    cnoreabbrev afn Afn
    cnoreabbrev fn Fn
    cnoreabbrev afunc Afunc
    cnoreabbrev func Func
    cnoreabbrev clog Clog
  ]])
  
else
  -- ============================================================================
  -- 通常のNeovim環境用設定
  -- ============================================================================
  
  -- 行番号表示
  vim.opt.number = true
  vim.opt.relativenumber = true
  
  -- インデント設定
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  
  -- カーソル行をハイライト
  vim.opt.cursorline = true
  
  -- 24-bit color support (カラースキーム用)
  vim.opt.termguicolors = true
  
  -- 背景をダークに設定
  vim.o.background = "dark"
  
  -- jjマッピング（通常のNeovim用）
  vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
  
  -- ファイル保存
  vim.keymap.set("n", "<leader>w", ":write<CR>", { noremap = true, silent = true, desc = "Save file" })
  
  -- ============================================================================
  -- スニペット（関数雛形）設定 - abbreviation
  -- 挿入モードで略語を入力後、スペースやEnterで展開
  -- ============================================================================
  
  vim.cmd([[
    iabbrev afn async () => {}<Left>
    iabbrev fn () => {}<Left>
    iabbrev afunc async function name() {}<Left>
    iabbrev func function name() {}<Left>
    iabbrev clog console.log()<Left>
  ]])
  
  -- ============================================================================
  -- プラグイン管理 (lazy.nvim)
  -- ============================================================================
  
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
  
  -- プラグイン設定
  require("lazy").setup({
    -- oil.nvim: ファイル操作
    {
      "stevearc/oil.nvim",
      config = function()
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
    },
    
    -- oil-git.nvim: oil.nvimにGit統合を追加
    -- {
    --   "benomahony/oil-git.nvim",
    --   dependencies = { "stevearc/oil.nvim" },
    --   -- セットアップ不要、自動で動作します
    -- },
    
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
    
    -- toggleterm.nvim: ターミナル管理
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        require("toggleterm").setup({
          size = 100,
          open_mapping = [[<leader>t]],  -- <c-t>はタブと競合するため<leader>tに変更
          hide_numbers = true,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = true,
          direction = 'float',
          close_on_exit = true,
        })
        
        -- ターミナルウィンドウのキーマッピング
        function _G.set_terminal_keymaps()
          local opts = {buffer = 0}
          vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end
        
        vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
      end,
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
    
    -- nvim-treesitter: シンタックスハイライトとフォールド
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter").setup({
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
    },
    
    -- catppuccin: カラースキーム
    -- {
    --   "catppuccin/nvim",
    --   name = "catppuccin",
    --   priority = 1000,
    --   config = function()
    --     require("catppuccin").setup({
    --       flavour = "macchiato", -- latte, frappe, macchiato, mocha
    --       transparent_background = false,
    --       show_end_of_buffer = false,
    --       term_colors = false,
    --       dim_inactive = {
    --         enabled = false,
    --         shade = "dark",
    --         percentage = 0.15,
    --       },
    --       no_italic = false,
    --       no_bold = false,
    --       no_underline = false,
    --       styles = {
    --         comments = { "italic" },
    --         conditionals = { "italic" },
    --         loops = {},
    --         functions = {},
    --         keywords = {},
    --         strings = {},
    --         variables = {},
    --         numbers = {},
    --         booleans = {},
    --         properties = {},
    --         types = {},
    --         operators = {},
    --       },
    --       integrations = {
    --         cmp = true,
    --         gitsigns = true,
    --         nvimtree = true,
    --         telescope = true,
    --         treesitter = true,  -- treesitter統合を有効化
    --         notify = false,
    --         mini = {
    --           enabled = true,
    --           indentscope_color = "",
    --         },
    --       },
    --     })
        
    --     -- カラースキームを設定
    --     vim.cmd.colorscheme "catppuccin"
    --   end,
    -- },
  })
end
