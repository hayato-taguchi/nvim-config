# Neovim Configuration

VSCode Neovim と 通常の Neovim 両対応の設定ファイル。

## 必要環境

- **Neovim** 0.11.0+（LSP 標準 API を使用）
- **iTerm2**（True Color 対応のため）
- **Nerd Font**（アイコン表示のため）
  ```bash
  brew install --cask font-hack-nerd-font
  ```
- **Node.js**（Prettier のため）
- **ripgrep**（Telescope grep 用）
  ```bash
  brew install ripgrep
  ```
- **lua-language-server**（Lua LSP）
  ```bash
  brew install lua-language-server
  ```

## インストール

```bash
# このリポジトリをclone
git clone <repo-url> ~/.config/nvim

# nvimを起動すると自動でプラグインがインストールされる
nvim
```

## ファイル構成

```
~/.config/nvim/
├── init.lua                    # エントリポイント
├── after/                      # init.lua読み込み後に自動読み込み
│   └── lsp/                    # LSPサーバー個別設定（自動読み込み）
│       └── lua_ls.lua          # Lua LSP設定
└── lua/
    ├── config/
    │   ├── options.lua         # 基本設定
    │   ├── keymaps.lua         # キーマッピング
    │   ├── lsp.lua             # LSP設定（Neovim 0.11標準API）
    │   └── vscode.lua          # VSCode専用設定
    └── plugins/
        ├── colorscheme.lua     # catppuccin
        ├── oil.lua             # ファイルエクスプローラー
        ├── git.lua             # Git関連
        ├── toggleterm.lua      # ターミナル
        ├── treesitter.lua      # シンタックスハイライト
        ├── no-neck-pain.lua    # 中央寄せ
        ├── conform.lua         # コードフォーマッター
        ├── telescope.lua       # ファジーファインダー
        ├── which-key.lua       # キーマップヘルプ
        ├── nvim-lspconfig.lua  # nvim-lspconfigプラグイン
        ├── lualine.lua         # ステータスライン
        ├── bufferline.lua      # タブ風バッファ
        └── noice.lua           # モダンUI
```

## キーマップ一覧

リーダーキー: `<Space>`

### 基本操作

| キー       | 説明                                 |
| ---------- | ------------------------------------ |
| `jj`       | Escape キー（挿入モードから抜ける）  |
| `<Space>w` | ファイル保存                         |
| `<Space>e` | ファイルエクスプローラー（oil.nvim） |
| `-`        | 親ディレクトリを開く                 |

### ファイル検索（Telescope）

| キー             | 説明                            |
| ---------------- | ------------------------------- |
| `<Space><Space>` | ファイル検索                    |
| `<Space>ff`      | ファイル検索                    |
| `<Space>fg`      | grep 検索（ファイル内容を検索） |
| `<Space>fb`      | バッファ一覧                    |
| `<Space>fr`      | 最近開いたファイル              |
| `<Space>fw`      | カーソル下の単語を検索          |
| `<Space>fh`      | ヘルプタグ検索                  |

### バッファ操作

| キー        | 説明                       |
| ----------- | -------------------------- |
| `Tab`       | 次のバッファ               |
| `Shift+Tab` | 前のバッファ               |
| `<Space>bx` | バッファを閉じる           |
| `<Space>bo` | 他のバッファをすべて閉じる |
| `<Space>bp` | バッファをピン留め         |

### LSP（コード操作）

| キー       | 説明                          |
| ---------- | ----------------------------- |
| `gd`       | 定義へジャンプ                |
| `<Space>k` | ホバードキュメント表示        |
| `<C-n>`    | 補完候補を次へ（Neovim 標準） |
| `<C-p>`    | 補完候補を前へ（Neovim 標準） |
| `<C-y>`    | 補完を確定（Neovim 標準）     |

> 補完は Neovim 0.11 の標準補完 API を使用しています。入力中に自動で候補が表示されます。

### コードフォーマット

| キー        | 説明                         |
| ----------- | ---------------------------- |
| `<Space>cf` | 手動フォーマット             |
| （保存時）  | 自動で Prettier が実行される |

### Git

| キー         | 説明                |
| ------------ | ------------------- |
| `<Space>gg`  | LazyGit を開く      |
| `<Space>gd`  | Diffview を開く     |
| `<Space>gdc` | Diffview を閉じる   |
| `<Space>gdh` | ファイル履歴を表示  |
| `]c`         | 次の変更箇所へ      |
| `[c`         | 前の変更箇所へ      |
| `<Space>hs`  | 変更をステージ      |
| `<Space>hr`  | 変更をリセット      |
| `<Space>hp`  | 変更をプレビュー    |
| `<Space>hb`  | この行の blame 表示 |

### ターミナル

| キー        | 説明                                  |
| ----------- | ------------------------------------- |
| `<Space>t`  | フローティングターミナルを開く/閉じる |
| `1<Space>t` | ターミナル 1 を開く                   |
| `2<Space>t` | ターミナル 2 を開く                   |
| `3<Space>t` | ターミナル 3 を開く（以降同様）       |
| `Esc`       | ターミナルモードから抜ける            |
| `jk`        | ターミナルモードから抜ける            |

### UI

| キー        | 説明                                |
| ----------- | ----------------------------------- |
| `<Space>nn` | No Neck Pain（中央寄せ）のオン/オフ |
| `<Space>nd` | 通知を消す                          |

### ファイルエクスプローラー（oil.nvim 内）

| キー    | 説明                                               |
| ------- | -------------------------------------------------- |
| `Enter` | ファイルを開く / ディレクトリに入る                |
| `-`     | 親ディレクトリへ戻る                               |
| `gd`    | 詳細表示の切り替え（パーミッション、サイズ、日時） |

## プラグイン一覧

| プラグイン        | 説明                                |
| ----------------- | ----------------------------------- |
| catppuccin        | カラースキーム（mocha）             |
| oil.nvim          | ファイルエクスプローラー            |
| gitsigns.nvim     | Git 差分をインライン表示            |
| lazygit.nvim      | LazyGit 統合                        |
| diffview.nvim     | Git 差分ビューア                    |
| toggleterm.nvim   | フローティングターミナル            |
| nvim-treesitter   | シンタックスハイライト              |
| no-neck-pain.nvim | エディタを中央に配置                |
| conform.nvim      | コードフォーマッター（Prettier 等） |
| telescope.nvim    | ファジーファインダー                |
| which-key.nvim    | キーマップヘルプ表示                |
| nvim-lspconfig    | LSP プリセット集                    |
| lualine.nvim      | ステータスライン                    |
| bufferline.nvim   | タブ風バッファ表示                  |
| noice.nvim        | モダンな UI                         |

## LSP サーバー

Neovim 0.11 の標準 API を使用しています（nvim-lspconfig でプリセットを読み込み）。

### 有効なサーバー

- `lua_ls` - Lua

### 言語サーバーの追加方法

1. 言語サーバーを手動でインストール（例: `brew install lua-language-server`）
2. `lua/config/lsp.lua` の `vim.lsp.enable()` に追加
3. 必要に応じて `after/lsp/<server_name>.lua` で個別設定

```lua
-- lua/config/lsp.lua
vim.lsp.enable({
  "lua_ls",
  "ts_ls",  -- 追加する場合
})
```

## Tips

### which-key でキーマップを確認

`<Space>` を押して少し待つと、利用可能なキーマップ一覧が表示されます。

### フォーマッターについて

保存時に自動でフォーマットが実行されます。プロジェクトに `.prettierrc` などの設定ファイルがあれば、その設定が使われます。

### ターミナルについて

`<Space>t` でフローティングターミナルが開きます。fish シェルがそのまま使えます。
