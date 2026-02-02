$results = @()

function Parse-FrontMatter {
    param ($content)
    if ($content.Count -lt 3) { return $null }
    if ($content[0].Trim() -ne '---') { return $null }
    
    $fm = @{}
    $i = 1
    while ($i -lt $content.Count -and $content[$i].Trim() -ne '---') {
        $line = $content[$i]
        if ($line -match '^(?<key>\w+):\s*(?<value>.*)$') {
            $fm[$Matches.key] = $Matches.value
        }
        $i++
    }
    return $fm
}

function Check-File {
    param ($path, $type)
    
    $compliance = $true
    $issues = @()
    
    if (-not (Test-Path $path)) {
        return @{ File = $path; Type = $type; Compliant = $false; Issues = @("File not found") }
    }
    
    $content = Get-Content $path
    $hasFrontMatter = ($content.Count -gt 0) -and ($content[0].Trim() -eq '---')
    
    if ($type -eq 'Rule') {
        if ($hasFrontMatter) {
            $compliance = $false
            $issues += "Should NOT have frontmatter"
        }
    } else {
        # Workflow or Skill
        if (-not $hasFrontMatter) {
            $compliance = $false
            $issues += "Missing frontmatter"
        } else {
            $fm = Parse-FrontMatter -content $content
            if ($null -eq $fm) {
                 $compliance = $false
                 $issues += "Invalid frontmatter"
            } else {
                if (-not $fm.ContainsKey('name') -and -not $fm.ContainsKey('Name')) { 
                    # check for name (case insensitive key check usually covered by hash table, but making sure)
                     $compliance = $false
                     $issues += "Missing 'name' field"
                } "name", "Name" | ForEach-Object { if ($fm.ContainsKey($_)) { $hasName = $true } }
                
                 if (-not $fm.ContainsKey('description') -and -not $fm.ContainsKey('Description')) {
                     $compliance = $false
                     $issues += "Missing 'description' field"
                }
            }
        }
    }
    
    return @{
        File = ($path | Split-Path -Leaf)
        Type = $type
        Compliant = $compliance
        Issues = ($issues -join ", ")
    }
}

$workflows = @(
    ".agent/workflows/startproject.md",
    ".agent/workflows/plan.md",
    ".agent/workflows/tdd.md",
    ".agent/workflows/simplify.md",
    ".agent/workflows/checkpoint.md",
    ".agent/workflows/init.md"
)

$skills = @(
    ".agent/skills/codex-system/SKILL.md",
    ".agent/skills/design-tracker/SKILL.md",
    ".agent/skills/research/SKILL.md",
    ".agent/skills/update-design/SKILL.md",
    ".agent/skills/update-lib-docs/SKILL.md"
)

$rules = @(
    ".agent/rules/language.md",
    ".agent/rules/codex-delegation.md",
    ".agent/rules/delegation-triggers.md",
    ".agent/rules/role-boundaries.md",
    ".agent/rules/coding-principles.md",
    ".agent/rules/dev-environment.md",
    ".agent/rules/security.md",
    ".agent/rules/testing.md"
)

foreach ($f in $workflows) { $results += Check-File -path $f -type "Workflow" }
foreach ($f in $skills) { $results += Check-File -path $f -type "Skill" }
foreach ($f in $rules) { $results += Check-File -path $f -type "Rule" }

$results | ConvertTo-Json
