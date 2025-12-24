# Neovim Configuration

VSCode Neovim と 通常の Neovim 両対応の設定ファイル。

## 必要環境

- **Neovim** 0.9.0+
- **iTerm2**（True Color 対応のため）
- **Nerd Font**（アイコン表示のため）
  ```bash
  brew install --cask font-hack-nerd-font
  ```
- **Node.js**（LSP、Prettier のため）
- **ripgrep**（Telescope grep 用）
  ```bash
  brew install ripgrep
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
└── lua/
    ├── config/
    │   ├── options.lua         # 基本設定
    │   ├── keymaps.lua         # キーマッピング
    │   └── vscode.lua          # VSCode専用設定
    └── plugins/
        ├── init.lua            # lazy.nvimセットアップ
        ├── colorscheme.lua     # catppuccin
        ├── oil.lua             # ファイルエクスプローラー
        ├── git.lua             # Git関連
        ├── toggleterm.lua      # ターミナル
        ├── treesitter.lua      # シンタックスハイライト
        ├── no-neck-pain.lua    # 中央寄せ
        ├── conform.lua         # コードフォーマッター
        ├── telescope.lua       # ファジーファインダー
        ├── which-key.lua       # キーマップヘルプ
        ├── lsp.lua             # LSP + 補完
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

| キー        | 説明                   |
| ----------- | ---------------------- |
| `gd`        | 定義へジャンプ         |
| `gD`        | 宣言へジャンプ         |
| `gr`        | 参照一覧               |
| `gi`        | 実装へジャンプ         |
| `K`         | ホバードキュメント表示 |
| `<Space>ca` | コードアクション       |
| `<Space>rn` | シンボルをリネーム     |
| `<Space>cd` | 行のエラー詳細を表示   |
| `[d`        | 前のエラーへ移動       |
| `]d`        | 次のエラーへ移動       |

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
| mason.nvim        | LSP サーバー管理                    |
| nvim-lspconfig    | LSP 設定                            |
| nvim-cmp          | 自動補完                            |
| lualine.nvim      | ステータスライン                    |
| bufferline.nvim   | タブ風バッファ表示                  |
| noice.nvim        | モダンな UI                         |

## LSP サーバー

以下の LSP サーバーが自動インストールされます：

- `lua_ls` - Lua
- `ts_ls` - TypeScript / JavaScript
- `pyright` - Python
- `jsonls` - JSON
- `yamlls` - YAML
- `html` - HTML
- `cssls` - CSS

`:Mason` コマンドで追加の LSP サーバーをインストールできます。

## Tips

### which-key でキーマップを確認

`<Space>` を押して少し待つと、利用可能なキーマップ一覧が表示されます。

### フォーマッターについて

保存時に自動でフォーマットが実行されます。プロジェクトに `.prettierrc` などの設定ファイルがあれば、その設定が使われます。

### ターミナルについて

`<Space>t` でフローティングターミナルが開きます。fish シェルがそのまま使えます。
