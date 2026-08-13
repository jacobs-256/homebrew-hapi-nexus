# HAPI Nexus Homebrew Tap

**语言：** [English](README.md) | 简体中文

这是用于在 macOS 上安装 HAPI Nexus 客户端的 Homebrew tap。

HAPI Nexus 是面向企业私有部署的平台：在本地运行 AI coding agent，并通过私有 Hub/Web 控制台远程控制。

这个 tap 只安装客户端命令：

```bash
hapi
```

它不会安装 `hapi-server`，不包含 Hub/Web 服务器，也不会自动启动本地 Hub。

## 安装

```bash
brew install jacobs-256/hapi-nexus/hapi
hapi --version
```

## 升级

```bash
brew update
brew upgrade hapi
hapi --version
```

## 卸载

```bash
brew uninstall hapi
```

## 连接到 Hub

使用 Hub 地址，以及 Web UI **Settings -> Account** 中当前用户的个人 access token。

```bash
export HAPI_API_URL="https://hapi.example.com"
hapi auth login
hapi auth status
```

非交互式配置：

```bash
HAPI_API_URL="https://hapi.example.com" \
CLI_API_TOKEN="<personal-access-token>" \
hapi auth status
```

客户端配置默认保存在 `~/.hapi`。可以用 `HAPI_HOME` 指定其他配置目录。

## 启动 Runner

Runner 允许 Web 应用在这台机器上启动会话，并且只浏览允许的 workspace root。

```bash
hapi runner start --workspace-root /path/to/projects
```

同一台机器需要多个允许目录时，可以重复传入：

```bash
hapi runner start \
  --workspace-root /path/a \
  --workspace-root /path/b
```

常用 runner 命令：

```bash
hapi runner status
hapi runner logs
hapi runner stop
```

如果使用 `systemd`、`launchd`、`pm2` 或 Docker 等进程管理器：

```bash
hapi runner start-sync --workspace-root /path/to/projects
```

## 启动本地 Agent 会话

请先安装并登录你要使用的 agent CLI。

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

## 服务端包

私有 Hub/Web 服务器作为 `hapi-server` 单独发布在主项目 GitHub Releases 中。

启动服务端：

```bash
hapi-server hub
```

生产部署请使用服务端 release 包，并参考主项目部署文档。

## 故障排查

查看安装版本：

```bash
hapi --version
```

检查认证状态：

```bash
hapi auth status
```

如果 runner 无法连接，请检查：

- `HAPI_API_URL` 是否指向你的 HAPI Nexus Hub。
- Hub 是否通过单独的 `hapi-server` 包启动。
- `CLI_API_TOKEN` 是否为当前用户的个人 access token。
- 当前用户是否有目标 machine 或 project 权限。
- 如果反向代理要求额外请求头，是否已设置 `HAPI_EXTRA_HEADERS_JSON`。

Linux 和 Windows 用户请从 GitHub Releases 下载匹配平台的 `hapi` 客户端压缩包，不通过 Homebrew 安装。

## 链接

- 主项目：https://github.com/jacobs-256/hapi-nexus
- Releases：https://github.com/jacobs-256/hapi-nexus/releases
- Issues：https://github.com/jacobs-256/hapi-nexus/issues

## 许可证

这个 tap 使用 GNU Affero General Public License v3.0 only 发布。见 [LICENSE](LICENSE)。
