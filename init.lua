-- ============================================================================
-- Neovim Configuration (VSCode Neovim & 通常のNeovim両対応)
-- ============================================================================

-- リーダーキーをスペースに設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本設定（両環境共通）
vim.opt.clipboard = "unnamedplus"  -- システムクリップボードを使用
vim.opt.hlsearch = true            -- 検索ハイライトを有効化
vim.opt.ignorecase = true          -- 検索時に大文字小文字を区別しない
vim.opt.smartcase = true           -- 大文字が含まれている場合は区別する
vim.opt.timeoutlen = 500           -- キーマッピングのタイムアウト（ミリ秒）

-- VSCode環境かどうかで分岐
if vim.g.vscode then
  require("config.vscode")
else
  require("config.options")
  require("config.keymaps")
  require("plugins")
end
