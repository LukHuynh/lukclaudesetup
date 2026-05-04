# Luk Claude Setup

One-command Claude Code environment bootstrap for macOS (Apple Silicon).

Clone this repo on any new machine and run `./setup.sh` to get the exact same environment.

## What's included

| Component | Details |
|-----------|---------|
| **Claude Code CLI** | Latest via npm |
| **Plugins** | ECC (48 agents, 182 skills), Caveman, Karpathy Skills, Last30Days |
| **48 AI Agents** | planner, architect, tdd-guide, code-reviewer, security-reviewer, and 43 more |
| **91 Rule files** | Common + language-specific (TS, Python, Go, Rust, Swift, Web, etc.) |
| **MCP Servers** | 25+ servers: GitHub, Jira, Confluence, Supabase, Exa, Firecrawl, Playwright, and more |
| **Dotfiles** | `.zshrc` with Node/cargo PATH setup |

## Quick Start

```bash
git clone https://github.com/LukHuynh/lukclaudesetup.git
cd lukclaudesetup

# 1. Fill in API keys
cp .env.example .env
nano .env

# 2. Run setup (macOS arm64 only)
chmod +x setup.sh
./setup.sh

# 3. Reload shell + authenticate
source ~/.zshrc
claude
```

## What `setup.sh` does

1. **Homebrew** — installs if missing
2. **Node.js** — installs via fnm to `~/.local/node`
3. **Python + uvx** — installs uv (provides uvx for Python MCP servers)
4. **Claude Code CLI** — `npm install -g @anthropic-ai/claude-code`
5. **Claude Plugins** — ECC, Caveman, Karpathy Skills, Last30Days
6. **Claude Config** — copies agents, rules, settings, AGENTS.md
7. **MCP Servers** — configures all 25+ servers (key-gated ones skip if no .env)
8. **Dotfiles** — appends PATH setup to `.zshrc`

Each script is idempotent — safe to re-run.

## MCP Servers

| Server | Auth Required | Purpose |
|--------|--------------|---------|
| memory | No | Persistent memory across sessions |
| omega-memory | No | Semantic search memory |
| sequential-thinking | No | Chain-of-thought reasoning |
| context7 | No | Live docs lookup |
| playwright | No | Browser automation |
| vercel | No | Deployments |
| cloudflare-* | No | CF docs, workers, logs |
| railway | No | Railway deployments |
| clickhouse | No | Analytics queries |
| laraplugins | No | Laravel plugin discovery |
| github | `GITHUB_PERSONAL_ACCESS_TOKEN` | PRs, issues, repos |
| jira | `JIRA_*` | Issue tracking |
| confluence | `CONFLUENCE_*` | Wiki search |
| firecrawl | `FIRECRAWL_API_KEY` | Web scraping |
| exa-web-search | `EXA_API_KEY` | Web search |
| fal-ai | `FAL_KEY` | AI image/video gen |
| browserbase | `BROWSERBASE_API_KEY` | Cloud browser sessions |
| supabase | `SUPABASE_PROJECT_REF` | Database ops |
| evalview | `OPENAI_API_KEY` (optional) | Agent regression testing |

## Claude Agents

48 specialized agents including:

- **Planning**: `planner`, `architect`, `code-architect`, `code-explorer`
- **Review**: `code-reviewer`, `typescript-reviewer`, `python-reviewer`, `go-reviewer`, `rust-reviewer`, `kotlin-reviewer`, `java-reviewer`, `cpp-reviewer`, `flutter-reviewer`
- **Build Fix**: `build-error-resolver`, `go-build-resolver`, `rust-build-resolver`, `kotlin-build-resolver`, `java-build-resolver`, `dart-build-resolver`, `pytorch-build-resolver`
- **Quality**: `tdd-guide`, `security-reviewer`, `performance-optimizer`, `database-reviewer`, `e2e-runner`
- **Workflow**: `refactor-cleaner`, `doc-updater`, `loop-operator`, `harness-optimizer`

## Custom Rules

Beyond ECC defaults, this setup adds:

- `common/self-improvement.md` — lessons loop, verification gate, stop-and-replan
- Updated `common/development-workflow.md` — guiding behaviors, task management
- `UserPromptSubmit` hook — surfaces `tasks/lessons.md` at session start

## Repository Structure

```
lukclaudesetup/
├── setup.sh                    # Main entry point
├── .env.example                # API key template
├── scripts/
│   ├── 01-homebrew.sh
│   ├── 02-node.sh
│   ├── 03-python-uvx.sh
│   ├── 04-claude-cli.sh
│   ├── 05-claude-plugins.sh
│   ├── 06-claude-config.sh
│   ├── 07-mcp-setup.sh
│   └── 08-dotfiles.sh
├── claude/
│   ├── settings.json
│   ├── AGENTS.md
│   ├── agents/                 # 48 agent definitions
│   ├── rules/                  # 91 rule files (common + languages)
│   └── mcp-configs/
│       └── mcp-servers.json    # Reference (values are YOUR_*_HERE)
└── dotfiles/
    └── .zshrc
```

## Keeping in Sync

When you update your setup on one machine, run:

```bash
cd lukclaudesetup

# Update agents + rules from current machine
cp -r ~/.claude/agents/. claude/agents/
cp -r ~/.claude/rules/. claude/rules/
cp ~/.claude/settings.json claude/settings.json
cp ~/.claude/AGENTS.md claude/AGENTS.md

git add -A
git commit -m "chore: sync claude config from $(hostname)"
git push
```

Then on any other machine:

```bash
git pull
./setup.sh
```
