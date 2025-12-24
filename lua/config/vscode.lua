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

