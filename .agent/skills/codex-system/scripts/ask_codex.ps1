# Codex CLI 相談スクリプト
# 使用方法: .\ask_codex.ps1 -Mode "analyze" -Question "質問内容"

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("analyze", "design", "debug", "review")]
    [string]$Mode,
    
    [Parameter(Mandatory=$true)]
    [string]$Question,
    
    [string]$Context = ""
)

# ============================================================
# パス設定（環境に合わせて変更してください）
# ============================================================
# WSL で以下のコマンドを実行してパスを確認：
#   which node
#   which codex
# 
# 例: /home/username/.nvm/versions/node/v22.15.0/bin/node
#     /home/username/.nvm/versions/node/v22.15.0/bin/codex

# Review the following paths and update them to match your environment. 
# Run 'which node' and 'which codex' in WSL to find the correct paths.
$NODE_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/vXX.XX.X/bin/node"
$CODEX_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/vXX.XX.X/bin/codex"

# ============================================================
# 以下は変更不要
# ============================================================

# タイムスタンプ
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputDir = "logs/codex-responses"
$outputFile = "$outputDir/$Mode-$timestamp.md"

# 出力ディレクトリ作成
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# プロンプト構築
$prompt = @"
## Task Type: $Mode

## Question
$Question

## Context
$Context

## Instructions
- Analyze thoroughly before responding
- Provide structured output with clear sections
- Include trade-offs and alternatives where applicable
- Respond in English for reasoning accuracy
"@

# WSL経由でCodex実行
# Determine WSL path for current directory (Manual conversion)
$windowsPath = (Get-Location).Path
$wslProjectDir = $windowsPath -replace '^([A-Z]):', { '/mnt/' + $_.Groups[1].Value.ToLower() } -replace '\\', '/'

$wslCommand = @"
export PATH="$($NODE_PATH -replace '/node$',''):`$PATH"
cd "$wslProjectDir"
echo '$($prompt -replace "'","'\''")' | $CODEX_PATH exec --model gpt-5.2-codex --sandbox read-only --full-auto --skip-git-repo-check 2>/dev/null
"@

Write-Host "=== Consulting Codex CLI ($Mode) ===" -ForegroundColor Cyan
Write-Host "Question: $Question" -ForegroundColor Yellow
Write-Host ""

try {
    $result = wsl bash -c $wslCommand
    
    if ($result) {
        # 結果を保存
        $result | Out-File -FilePath $outputFile -Encoding utf8
        
        # 結果を出力
        Write-Host "=== Codex Response ===" -ForegroundColor Green
        Write-Host $result
        Write-Host ""
        Write-Host "Response saved to: $outputFile" -ForegroundColor Gray
    } else {
        Write-Host "No response from Codex. Check if Codex CLI is properly installed." -ForegroundColor Red
    }
} catch {
    Write-Host "Error executing Codex: $_" -ForegroundColor Red
    Write-Host "Please check:" -ForegroundColor Yellow
    Write-Host "  1. WSL is installed and running" -ForegroundColor Yellow
    Write-Host "  2. Codex CLI is installed in WSL" -ForegroundColor Yellow
    Write-Host "  3. Paths in this script are correct" -ForegroundColor Yellow
}
