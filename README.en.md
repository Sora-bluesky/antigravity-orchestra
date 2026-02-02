# 🎼 Antigravity Orchestra

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20WSL2-blue.svg)](#prerequisites)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Sora-bluesky/antigravity-orchestra/issues)

**🌐 Language: [日本語](README.md) | English**

---

**Antigravity Orchestra** is a multi-agent development template that orchestrates [Google Antigravity](https://antigravity.google) (Gemini 3 Pro) and [OpenAI Codex CLI](https://github.com/openai/codex) for AI-powered development workflows.

Inspired by [Claude Code Orchestra](https://github.com/DeL-TaiseiOzaki/claude-code-orchestra) by @mkj (Matsuo Institute).

---

## ✨ What is This?

```
┌─────────────────────────────────────────────────────────────┐
│                        User                                 │
│                          │                                  │
│                          ▼                                  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │    Google Antigravity (Orchestrator + Researcher)     │  │
│  │    → Gemini 3 Pro / 1M token context                  │  │
│  │    → User interaction, research, implementation       │  │
│  │                                                       │  │
│  │        ┌─────────────────────────────────────────┐    │  │
│  │        │   Codex CLI (via Skills scripts/)       │    │  │
│  │        │   → Design, Debug, Review               │    │  │
│  │        └─────────────────────────────────────────┘    │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

**Single interface - Antigravity only.** Users interact only with Antigravity, which delegates to Codex when needed.

---

## 🎯 Who is This For?

- Using Antigravity but want better design and review quality
- Finding it tedious to switch between multiple AIs
- Want code checked from both Google and OpenAI perspectives

---

## 🎭 Role Distribution

| Role | Agent | Tasks |
|------|-------|-------|
| **Orchestrator** | Antigravity | User interaction, task management, workflow control |
| **Researcher** | Antigravity | Library research, documentation search (1M token context) |
| **Builder** | Antigravity | Code implementation based on Codex's design |
| **Designer** | Codex CLI | Architecture design, implementation planning, trade-off analysis |
| **Debugger** | Codex CLI | Root cause analysis, complex bug investigation |
| **Auditor** | Codex CLI | Code review, quality checks, TDD design |

---

## 📋 Prerequisites

| Requirement | How to Check | Notes |
|-------------|--------------|-------|
| Google Antigravity | Can launch Antigravity | [Official Site](https://antigravity.google) |
| WSL2 (Ubuntu) | `wsl --version` in PowerShell | [Install Guide](https://zenn.dev/sora_biz/articles/wsl2-windows-install-guide) |
| Node.js (in WSL2) | `node --version` in WSL | [nodejs.org](https://nodejs.org) |
| Codex CLI (in WSL2) | `codex --version` in WSL | `npm i -g @openai/codex` |
| ChatGPT Plus/Pro | OpenAI subscription | $20/month~ (OAuth sign-in) |

---

## 🚀 Quick Start

### Step 1: Clone the Template

Open WSL2 (Ubuntu) terminal:

```bash
# Navigate to your projects folder
cd /mnt/c/Users/YOUR_USERNAME/Documents/Projects

# Clone the template
git clone https://github.com/Sora-bluesky/antigravity-orchestra.git my-project

# Move into the project
cd my-project
```

### Step 2: Configure Paths

Check your Node.js and Codex paths in WSL2:

```bash
which node    # e.g., /home/YOUR_USERNAME/.nvm/versions/node/v22.x.x/bin/node
which codex   # e.g., /home/YOUR_USERNAME/.nvm/versions/node/v22.x.x/bin/codex
```

Edit `.agent/skills/codex-system/scripts/ask_codex.ps1` and update:

```powershell
$NODE_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/v22.x.x/bin/node"
$CODEX_PATH = "/home/YOUR_USERNAME/.nvm/versions/node/v22.x.x/bin/codex"
```

Also update `review.ps1` with the same paths.

### Step 3: Open in Antigravity

1. Launch **Antigravity** from Start menu or taskbar
2. Click **File → Open Folder** (or `Ctrl+K, Ctrl+O`)
3. Navigate to: `C:\Users\YOUR_USERNAME\Documents\Projects\my-project`
4. Click **Select Folder**

### Step 4: Try It!

In Antigravity's chat, type:

```
/startproject Hello World
```

Antigravity will automatically:

1. Analyze your project structure
2. Ask about requirements
3. Delegate design review to Codex
4. Create a task list
5. Document decisions in `docs/DESIGN.md`

---

## 📁 Directory Structure

```
my-project/
├── .agent/
│   ├── workflows/        # 6 workflows
│   │   ├── startproject.md   # Main workflow (6 phases)
│   │   ├── plan.md           # Implementation planning
│   │   ├── tdd.md            # Test-driven development
│   │   ├── simplify.md       # Refactoring
│   │   ├── checkpoint.md     # Session persistence
│   │   └── init.md           # Project initialization
│   │
│   ├── skills/           # 5 skills
│   │   ├── codex-system/     # Codex CLI integration
│   │   │   ├── SKILL.md
│   │   │   └── scripts/
│   │   │       ├── ask_codex.ps1
│   │   │       └── review.ps1
│   │   ├── design-tracker/
│   │   ├── research/
│   │   ├── update-design/
│   │   └── update-lib-docs/
│   │
│   └── rules/            # 8 rules
│       ├── delegation-triggers.md  # Auto-routing (Hooks alternative)
│       ├── role-boundaries.md      # Role separation
│       ├── language.md
│       ├── codex-delegation.md
│       ├── coding-principles.md
│       ├── dev-environment.md
│       ├── security.md
│       └── testing.md
│
├── .codex/               # Codex CLI configuration
│   └── AGENTS.md
│
├── docs/                 # Knowledge base
│   ├── DESIGN.md             # Design decisions
│   ├── research/             # Research results
│   └── libraries/            # Library constraints
│
└── logs/
    └── codex-responses/      # Codex consultation logs
```

---

## 📖 Workflows in Detail

### /startproject - Main Workflow (6 Phases)

```
┌─────────────────────────────────────────────────────────────────┐
│  Phase 1: Antigravity (Research)                                │
│  → Repository analysis, library research                        │
│  → Output: docs/research/{feature}.md                           │
├─────────────────────────────────────────────────────────────────┤
│  Phase 2: Antigravity (Requirements)                            │
│  → Requirements gathering (goals, scope, constraints, criteria) │
│  → Draft implementation plan                                    │
├─────────────────────────────────────────────────────────────────┤
│  Phase 3: Codex CLI (Design Review)                             │
│  → Reviews Phase 1 research + Phase 2 plan                      │
│  → Risk analysis, implementation order suggestions              │
├─────────────────────────────────────────────────────────────────┤
│  Phase 4: Antigravity (Task Creation)                           │
│  → Integrate all inputs                                         │
│  → Create task list, get user confirmation                      │
├─────────────────────────────────────────────────────────────────┤
│  Phase 5: Antigravity (Documentation)                           │
│  → Record design decisions in docs/DESIGN.md                    │
├─────────────────────────────────────────────────────────────────┤
│  Phase 6: Codex CLI (Quality Assurance)                         │
│  → Post-implementation review by Codex                          │
│  → Unbiased quality assurance                                   │
└─────────────────────────────────────────────────────────────────┘
```

### /plan - Implementation Planning

Create a detailed implementation plan with Codex's help.

```
/plan Add user authentication
```

### /tdd - Test-Driven Development

Codex designs test cases, Antigravity implements Red-Green-Refactor cycle.

```
/tdd Login functionality
```

### /simplify - Refactoring

Simplify and improve code readability.

```
/simplify src/auth/login.py
```

### /checkpoint - Session Persistence

Save session state for later continuation.

```
/checkpoint          # Basic: history log
/checkpoint --full   # Full: includes git history and file changes
```

---

## 🛠️ Skills in Detail

### codex-system - Codex CLI Integration

The core skill for delegating design, debugging, and review to Codex.

**Trigger Keywords:**

| Category | Keywords |
|----------|----------|
| Design | "design", "architecture", "how to build", "which approach", "trade-off" |
| Debug | "why doesn't work", "error", "bug", "debug" |
| Review | "review", "check", "verify" |

**When NOT to use:**
- Simple file editing
- Research/investigation (Antigravity handles this)
- User conversation

### Other Skills

| Skill | Purpose |
|-------|---------|
| design-tracker | Track and record design decisions to docs/DESIGN.md |
| research | Library research and documentation |
| update-design | Update DESIGN.md |
| update-lib-docs | Document library constraints |

---

## 📏 Rules in Detail

### delegation-triggers.md (Most Important)

Replaces Claude Code Orchestra's 6 Hooks with Rules-based routing.

**Decision Flow:**

```
Receive user input
    │
    ▼
[Check 1] Design decision needed?
    → Yes: Suggest /plan or use codex-system skill
    │
    ▼
[Check 2] TDD needed?
    → Yes: Suggest /tdd (Antigravity doesn't design tests directly)
    │
    ▼
[Check 3] Debugging needed?
    → Yes: Use codex-system skill
    │
    ▼
[Check 4] Implementation complete?
    → Yes: Suggest review with codex-system skill
    │
    ▼
Antigravity executes directly (research, file editing, etc.)
```

### role-boundaries.md (Role Separation)

| Antigravity Does | Codex Does |
|------------------|------------|
| User interaction | Test design (TDD) |
| Library research | Architecture design |
| File editing | Trade-off analysis |
| Code implementation | Root cause analysis |
| | Code review |

**Quick Rule: "Does this need a design decision?" → Delegate to Codex**

### Other Rules

| Rule | Content |
|------|---------|
| language.md | Think in English, respond to user in their language |
| codex-delegation.md | Detailed Codex delegation rules |
| coding-principles.md | Simplicity, single responsibility, early return |
| dev-environment.md | Development environment (uv, ruff, pytest, etc.) |
| security.md | Secret management, input validation |
| testing.md | TDD, AAA pattern, coverage goals |

---

## 💬 Basic Usage Examples

### Example 1: New Feature Development

```
/startproject User authentication
```

Antigravity automatically runs 6 phases.

### Example 2: Design Consultation

```
How should I design this feature?
```

Antigravity detects "design" keyword and delegates to Codex.

### Example 3: Debugging

```
I don't understand why this error occurs
```

Antigravity delegates root cause analysis to Codex.

### Example 4: Test-Driven Development

```
/tdd Login functionality
```

Codex designs test cases, Antigravity implements.

---

## ❓ FAQ

<details>
<summary><strong>Q: Can I use this without Codex CLI?</strong></summary>

Yes, but you'll lose the design review and debugging capabilities. Antigravity will handle everything directly, which may reduce code quality for complex projects.

</details>

<details>
<summary><strong>Q: Why is Codex called via PowerShell scripts?</strong></summary>

Antigravity runs on Windows, but Codex CLI works best in WSL2 (Linux). The PowerShell scripts bridge this gap by calling WSL commands.

</details>

<details>
<summary><strong>Q: How do I update the paths if I reinstall Node.js?</strong></summary>

1. Run `which node` and `which codex` in WSL2
2. Update the paths in `ask_codex.ps1` and `review.ps1`

</details>

<details>
<summary><strong>Q: Can I customize the workflows?</strong></summary>

Yes! Edit the files in `.agent/workflows/`. Each workflow is a Markdown file with frontmatter (name, description) and step-by-step instructions.

</details>

<details>
<summary><strong>Q: Do I need ChatGPT Plus or Pro?</strong></summary>

Plus ($20/month) is sufficient. Consider Pro ($200/month) if you need higher usage limits.

</details>

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Codex skill not triggered | Explicitly say "Ask Codex about this" or use keywords (design, debug, review) |
| Path not found error | Re-check `which node` and `which codex` in WSL2, update scripts |
| WSL not starting | Run `wsl --status` in PowerShell |
| Role boundary violated | Explicitly say "Delegate TDD to Codex" |

---

## ⚠️ Important Notes

- **Google Antigravity is in public preview.** Features and behavior may change.
- **Codex CLI requires a ChatGPT subscription.** Sign in via OAuth authentication.
- Check the [official site](https://antigravity.google) for the latest information.

---

## 🤝 Feedback

For bug reports or suggestions, please [open an issue](https://github.com/Sora-bluesky/antigravity-orchestra/issues).

---

## 🔗 Related Links

### References

| Resource | Author | Content |
|----------|--------|---------|
| [Claude Code Orchestra](https://zenn.dev/mkj/articles/claude-code-orchestra_20260120) | @mkj (Matsuo Institute) | Multi-agent coordination concept |
| [GitHub: claude-code-orchestra](https://github.com/DeL-TaiseiOzaki/claude-code-orchestra) | DeL-TaiseiOzaki | Implementation example |

### Tools

- [Google Antigravity](https://antigravity.google)
- [OpenAI Codex CLI](https://github.com/openai/codex)

### Related Articles (Japanese)

- [Antigravity Install Guide](https://zenn.dev/sora_biz/articles/antigravity-windows-install-guide)
- [WSL2 Install Guide](https://zenn.dev/sora_biz/articles/wsl2-windows-install-guide)
- [Detailed Usage Guide (Zenn)](https://zenn.dev/sora_biz/articles/antigravity-orchestra-guide)

---

## 📜 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

This project is inspired by **Claude Code Orchestra** by [@mkj](https://zenn.dev/mkj) (Matsuo Institute). The original architecture and concept of multi-agent coordination were adapted for Google Antigravity users.

---

📅 **Last Updated**: February 2, 2026
