# Antigravity Orchestra Template

Google Antigravity × Codex CLI でマルチエージェント協調開発を行うためのテンプレート。

## 概要

Claude Code Orchestra の考え方を Google Antigravity で再現するためのテンプレートです。

- **Antigravity**: オーケストレーター、リサーチャー、ビルダー
- **Codex CLI**: デザイナー、デバッガー、オーディター

## 必要環境

- Windows 11
- WSL2 (Ubuntu)
- Google Antigravity
- OpenAI Codex CLI

## セットアップ

### 1. テンプレートをダウンロード

```bash
git clone https://github.com/YOUR_USERNAME/antigravity-orchestra-template.git
cd antigravity-orchestra-template
```

### 2. パスの設定

WSL で以下のコマンドを実行してパスを確認：

```bash
which node
which codex
```

表示されたパスを `.agent/skills/codex-system/scripts/ask_codex.ps1` に設定：

```powershell
$NODE_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/v22.x.x/bin/node"
$CODEX_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/v22.x.x/bin/codex"
```

### 3. 動作確認

Antigravity で以下を実行：

```
/startproject Hello World を表示するプログラム
```

## ディレクトリ構成

```
.
├── .agent/
│   ├── workflows/      # ワークフロー（6個）
│   ├── skills/         # スキル（5個）
│   └── rules/          # ルール（8個）
├── .codex/
│   └── AGENTS.md       # Codex CLI 設定
├── docs/
│   ├── DESIGN.md       # 設計決定記録
│   ├── research/       # リサーチ結果
│   └── libraries/      # ライブラリ文書
└── logs/
    └── codex-responses/ # Codex 相談ログ
```

## 使い方

### 新機能の開発

```
/startproject お問い合わせフォーム
```

### 実装計画の作成

```
/plan TODOリストの保存機能
```

### テスト駆動開発

```
/tdd 電卓の足し算機能
```

### コードのリファクタリング

```
/simplify main.py
```

### セッションの保存

```
/checkpoint
```

## 詳細ドキュメント

- [Zenn 記事: Orchestra方式でタスク自動振り分け](https://zenn.dev/sora_biz/articles/antigravity-orchestra-guide)
- [Zenn 記事: デュアルエージェント開発](https://zenn.dev/sora_biz/articles/antigravity-codex-dual-agent-guide)

## 参考

このテンプレートは以下を参考に作成しました：

- [Claude Code Orchestra](https://zenn.dev/mkj/articles/claude-code-orchestra_20260120) by @mkj（松尾研究所）
- [GitHub: claude-code-orchestra](https://github.com/DeL-TaiseiOzaki/claude-code-orchestra)

## ライセンス

MIT License
