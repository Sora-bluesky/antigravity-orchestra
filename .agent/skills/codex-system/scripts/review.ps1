# Codex CLI レビュースクリプト
# 使用方法: .\review.ps1

# ============================================================
# パス設定（環境に合わせて変更してください）
# ============================================================
$NODE_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/v22.22.0/bin/node"
$CODEX_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/v22.22.0/bin/codex"

# ============================================================
# 以下は変更不要
# ============================================================

# タイムスタンプ
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputDir = "logs/codex-responses"
$outputFile = "$outputDir/review-$timestamp.md"

# 出力ディレクトリ作成
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# WSL経由でCodex実行（レビューモード）
# Determine WSL path for current directory (Manual conversion)
$windowsPath = (Get-Location).Path
$wslProjectDir = $windowsPath -replace '^([A-Z]):', { '/mnt/' + $_.Groups[1].Value.ToLower() } -replace '\\', '/'

$wslCommand = @"
export PATH="$($NODE_PATH -replace '/node$',''):`$PATH"
cd "$wslProjectDir"
$CODEX_PATH exec --model gpt-5.2-codex --sandbox read-only --full-auto "Review the recent changes in this project. Check for: 1) Code quality issues 2) Security concerns 3) Performance problems 4) Best practice violations. Provide specific recommendations." --skip-git-repo-check 2>/dev/null
"@

Write-Host "=== Starting Codex Review ===" -ForegroundColor Cyan
Write-Host ""

try {
    $result = wsl bash -c $wslCommand
    
    if ($result) {
        # 結果を保存
        $result | Out-File -FilePath $outputFile -Encoding utf8
        
        # 結果を出力
        Write-Host "=== Review Results ===" -ForegroundColor Green
        Write-Host $result
        Write-Host ""
        Write-Host "Review saved to: $outputFile" -ForegroundColor Gray
    } else {
        Write-Host "No response from Codex. Check if Codex CLI is properly installed." -ForegroundColor Red
    }
} catch {
    Write-Host "Error executing Codex: $_" -ForegroundColor Red
}
