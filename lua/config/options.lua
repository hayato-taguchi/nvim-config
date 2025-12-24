-- ============================================================================
-- 基本設定（通常のNeovim環境用）
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

