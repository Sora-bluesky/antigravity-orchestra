# 🎼 Antigravity Orchestra

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20WSL2-blue.svg)](#前提条件)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Sora-bluesky/antigravity-orchestra/issues)

[![日本語](https://img.shields.io/badge/lang-日本語-blue.svg)](#日本語)
[![English](https://img.shields.io/badge/lang-English-red.svg)](#english)

> AI agent orchestration template: Antigravity + Codex CLI

---

## English

**What is this?**
A multi-agent development template that orchestrates Google Antigravity (Gemini 3 Pro) and OpenAI Codex CLI for AI-powered development workflow.

**Key Features:**
- 🎯 Single interface - Talk only to Antigravity, it delegates to Codex when needed
- 🔄 6 Workflows + 5 Skills + 8 Rules pre-configured
- 📝 Design decisions automatically documented

**Quick Start:**

~~~bash
git clone https://github.com/Sora-bluesky/antigravity-orchestra.git
cd antigravity-orchestra
# Open this folder in Antigravity, then type: /startproject Hello World
~~~

📖 For detailed instructions, see [Zenn article (Japanese)](https://zenn.dev/sora_biz/articles/antigravity-orchestra-guide).

---

## 日本語

### ✨ これは何？

Google Antigravity と OpenAI Codex CLI を協調させる、AIマルチエージェント開発テンプレートです。

~~~
┌─────────────────────────────────────────────────────────┐
│                     ユーザー                            │
│                        │                               │
│                        ↓                               │
│  ┌─────────────────────────────────────────────────┐   │
│  │   Google Antigravity (オーケストレーター)        │   │
│  │   • ユーザー対話・リサーチ・実装                 │   │
│  │                    │                            │   │
│  │                    ↓ 設計/レビュー時            │   │
│  │         ┌─────────────────────┐                 │   │
│  │         │   Codex CLI         │                 │   │
│  │         │   • 設計レビュー     │                 │   │
│  │         │   • デバッグ         │                 │   │
│  │         │   • 品質チェック     │                 │   │
│  │         └─────────────────────┘                 │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
~~~

**インターフェースは Antigravity だけ。** 必要に応じて Antigravity が Codex に相談します。

### 🎯 こんな人におすすめ

- AIを使った開発に興味があるが、複数ツールの使い分けが難しい
- Antigravity を使っているが、設計やレビューの品質を上げたい
- Claude Code Orchestra の考え方を Antigravity で試したい

### 🚀 クイックスタート

~~~bash
# 1. クローン
git clone https://github.com/Sora-bluesky/antigravity-orchestra.git
~~~

#### Step 2: Antigravity でプロジェクトを開く

1. **Antigravity を起動**（タスクバーから、またはスタートメニューから）
2. **File → Open Folder** をクリック
3. **フォルダ選択ダイアログ**で以下に移動:
   - `C:\Users\{あなたのユーザー名}\Documents\Projects\my-project`
   （git clone で作成したフォルダ）
4. **「フォルダーの選択」**をクリック

:::message
**💡 ヒント**
エクスプローラーで `my-project` フォルダを開いた状態で、アドレスバーに `antigravity .` と入力しても開けます。
:::

#### Step 3: 動作確認

Antigravity のチャット欄に入力してください：

~~~bash
/startproject Hello World を表示するプログラム
~~~

### 📁 ディレクトリ構成

~~~
antigravity-orchestra/
├── .agent/
│   ├── workflows/          # 6 Workflows
│   │   ├── startproject.md # /startproject（メイン）
│   │   ├── plan.md         # /plan
│   │   ├── tdd.md          # /tdd
│   │   └── ...
│   ├── skills/             # 5 Skills
│   │   ├── codex-system/   # Codex CLI 連携
│   │   └── ...
│   └── rules/              # 8 Rules
│       ├── delegation-triggers.md  # 自動振り分け
│       └── ...
├── .codex/                 # Codex CLI 設定
├── docs/                   # 知識ベース
└── logs/                   # Codex 相談ログ
~~~

### 📋 前提条件

| 必要なもの | 確認方法 | インストールガイド |
|-----------|----------|-------------------|
| Google Antigravity | 起動できる | [ガイド](https://zenn.dev/sora_biz/articles/antigravity-windows-install-guide) |
| WSL2 (Ubuntu) | `wsl --version` | [ガイド](https://zenn.dev/sora_biz/articles/wsl2-windows-install-guide) |
| Node.js | `node --version` | [公式](https://nodejs.org) |
| Codex CLI | `codex --version` | `npm install -g @openai/codex` |
| OPENAI_API_KEY | `echo $OPENAI_API_KEY` | [OpenAI](https://platform.openai.com/api-keys) |

### 📖 詳しい使い方

詳細な手順は Zenn 記事をご覧ください：

📚 **[【非エンジニア×AI開発】Google Antigravity × Codex CLI 協調開発](https://zenn.dev/sora_biz/articles/antigravity-orchestra-guide)**

### ❓ よくある質問

<details>
<summary><strong>Q: Codex CLI がなくても使える？</strong></summary>

はい。Antigravity 単体でも Workflows は動作します。Codex 連携機能（設計レビュー、デバッグ委譲）は使えませんが、基本的な開発フローは体験できます。
</details>

<details>
<summary><strong>Q: 料金はかかる？</strong></summary>

- **Antigravity**: 無料（パブリックプレビュー）
- **Codex CLI**: ChatGPT Plus/Pro のサブスクリプションが必要です（$20/月〜）。OAuth認証でサインインして利用します。
  - ChatGPT Plus: $20/月
  - ChatGPT Pro: $200/月
  - API キー利用の場合は従量課金も可能
  - [詳細な料金情報](https://developers.openai.com/codex/pricing/)
</details>

<details>
<summary><strong>Q: Mac / Linux でも使える？</strong></summary>

現時点では Windows + WSL2 環境を前提としています。Mac/Linux 対応は今後検討予定です。
</details>

### ⚠️ 注意事項

- **Antigravity はパブリックプレビュー版**です。仕様変更やバグが発生する可能性があります
- 問題が発生した場合は [Issue](https://github.com/Sora-bluesky/antigravity-orchestra/issues) でお知らせください

### 🤝 Contributing

Issue や Pull Request は大歓迎です！

- 🐛 バグ報告: [Issue を作成](https://github.com/Sora-bluesky/antigravity-orchestra/issues/new)
- 💡 機能提案: [Issue を作成](https://github.com/Sora-bluesky/antigravity-orchestra/issues/new)
- 📝 ドキュメント改善: PR をお待ちしています

### 🔗 関連リンク

| ツール | リンク |
|--------|--------|
| Google Antigravity | [antigravity.google](https://antigravity.google) |
| OpenAI Codex CLI | [GitHub](https://github.com/openai/codex) |
| Zenn 記事 | [詳細ガイド](https://zenn.dev/sora_biz/articles/antigravity-orchestra-guide) |

### 📜 ライセンス

[MIT License](LICENSE)

### 🙏 謝辞

このテンプレートは以下の素晴らしいプロジェクトを参考にしています：

- [Claude Code Orchestra](https://zenn.dev/mkj/articles/claude-code-orchestra_20260120) by @mkj（松尾研究所）
- [GitHub: claude-code-orchestra](https://github.com/DeL-TaiseiOzaki/claude-code-orchestra)

---

<p align="center">
  Made with ❤️ by <a href="https://x.com/sora_biz">@sora_biz</a>
</p>
