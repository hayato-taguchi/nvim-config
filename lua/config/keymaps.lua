-- ============================================================================
-- キーマッピング（通常のNeovim環境用）
-- ============================================================================

-- jjマッピング
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- ファイル保存
vim.keymap.set("n", "<leader>w", ":write<CR>", { noremap = true, silent = true, desc = "Save file" })

