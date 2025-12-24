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

-- プラグイン設定を読み込み
require("lazy").setup({
  { import = "plugins.colorscheme" },
  { import = "plugins.oil" },
  { import = "plugins.git" },
  { import = "plugins.toggleterm" },
  { import = "plugins.treesitter" },
  { import = "plugins.no-neck-pain" },
  { import = "plugins.conform" },
  { import = "plugins.telescope" },
})

