# HAPI Nexus Homebrew Tap

**Language:** English | [简体中文](README.zh-CN.md)

Homebrew tap for installing the HAPI Nexus client on macOS.

HAPI Nexus is an enterprise-oriented private-deployment platform for running AI coding agents locally and controlling them remotely through a private Hub/Web console.

This tap installs only the client command:

```bash
hapi
```

It does not install `hapi-server`, does not include the Hub/Web server, and will not auto-start a local Hub.

## Install

```bash
brew install jacobs-256/hapi-nexus/hapi
hapi --version
```

## Upgrade

```bash
brew update
brew upgrade hapi
hapi --version
```

## Uninstall

```bash
brew uninstall hapi
```

## Connect to a Hub

Use the Hub URL and your personal access token from the Web UI **Settings -> Account**.

```bash
export HAPI_API_URL="https://hapi.example.com"
hapi auth login
hapi auth status
```

Non-interactive setup:

```bash
HAPI_API_URL="https://hapi.example.com" \
CLI_API_TOKEN="<personal-access-token>" \
hapi auth status
```

Client settings are stored under `~/.hapi` by default. Use `HAPI_HOME` to choose another config directory.

## Start a Runner

The runner lets the Web app start sessions on this machine and browse only allowed workspace roots.

```bash
hapi runner start --workspace-root /path/to/projects
```

Use multiple roots on the same machine when needed:

```bash
hapi runner start \
  --workspace-root /path/a \
  --workspace-root /path/b
```

Common runner commands:

```bash
hapi runner status
hapi runner logs
hapi runner stop
```

For supervised runs with `systemd`, `launchd`, `pm2`, or Docker:

```bash
hapi runner start-sync --workspace-root /path/to/projects
```

## Start Local Agent Sessions

Install and authenticate the agent CLI you plan to use first.

```bash
# Claude Code
hapi

# OpenAI Codex CLI
hapi codex
hapi codex resume <session-id>

# Cursor Agent
hapi cursor
hapi cursor resume <chat-id>

# Grok Build
hapi grok

# OpenCode
hapi opencode
```

## Server Package

The private Hub/Web server is distributed separately as `hapi-server` in the main GitHub Releases.

Run the server with:

```bash
hapi-server hub
```

For production deployments, use the server release package and the deployment documentation in the main project.

## Troubleshooting

Check the installed version:

```bash
hapi --version
```

Check authentication:

```bash
hapi auth status
```

If the runner cannot connect, verify:

- `HAPI_API_URL` points to your HAPI Nexus Hub.
- The Hub is running from the separate `hapi-server` package.
- `CLI_API_TOKEN` is the current user's personal access token.
- The current user has access to the target machine or project.
- Any reverse proxy headers are set with `HAPI_EXTRA_HEADERS_JSON` when required.

Linux and Windows users should download the matching `hapi` client archive from GitHub Releases instead of using Homebrew.

## Links

- Main project: https://github.com/jacobs-256/hapi-nexus
- Releases: https://github.com/jacobs-256/hapi-nexus/releases
- Issues: https://github.com/jacobs-256/hapi-nexus/issues

## License

This tap is distributed under the GNU Affero General Public License v3.0 only. See [LICENSE](LICENSE).
