-- telescope.nvim: ファジーファインダー
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    -- モノレポ向け: 無視パターン（find_files / live_grep 共通）
    local ignore_patterns = {
      "node_modules",
      ".git/",
      ".next/",
      "dist/",
      "build/",
      "__pycache__/",
      ".venv/",
      "venv/",
      ".cache/",
    }

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
          file_ignore_patterns = ignore_patterns,
          -- fd があれば使う（find より速い）
          find_command = (function()
            if vim.fn.executable("fd") == 1 then
              return { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
            end
            return nil
          end)(),
        },
        git_files = {
          file_ignore_patterns = ignore_patterns,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!.git/*" }
          end,
          file_ignore_patterns = ignore_patterns,
        },
      },
    })

    -- fzf拡張を読み込み
    pcall(telescope.load_extension, "fzf")

    -- Git リポジトリ内なら git_files（速い）、それ以外は find_files
    local function find_files_smart()
      vim.fn.system("git rev-parse --git-dir 2>/dev/null")
      if vim.v.shell_error == 0 then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end

    -- キーマップ
    vim.keymap.set("n", "<leader>ff", find_files_smart, { desc = "Find files (git or all)" })
    vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "Find all files (slow)" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
    vim.keymap.set("n", "<leader><leader>", find_files_smart, { desc = "Find files (git or all)" })
  end,
}



