# wechat-use

Give AI agents a real WeChat desktop they can see and operate.

wechat-use provides a persistent, agent-ready Linux WeChat environment. An AI agent connects to a token-protected MCP endpoint to automate the desktop, while a human can use the same environment in a browser to sign in, supervise the agent, or take over when needed.

Docker packages WeChat, its desktop dependencies, Chinese input support, and the automation service into a reproducible environment. It is the delivery mechanism; the goal is to make WeChat a practical tool for AI agents.

## What it provides

- **MCP desktop automation:** Let compatible AI agents interact with WeChat through a single automation endpoint.
- **A real desktop:** Preserve the full WeChat graphical interface instead of relying on an unofficial chat API.
- **Human supervision and handoff:** Open the same desktop in a browser to scan the login QR code, inspect the agent's work, or take control.
- **Persistent workspaces:** Keep login state and received files across restarts and updates.
- **Reproducible deployment:** Use Docker Compose to run the desktop and automation service with their required dependencies.

## How it works

```text
AI agent -> MCP -> Automation service -> Linux WeChat desktop <- Browser - Human
```

The agent and the human share the same WeChat session. The MCP endpoint is intended for agent automation; browser access is intended for setup, supervision, and manual intervention.

## Requirements

- A computer with Docker Engine and Docker Compose.
- A WeChat account and a residential IP address.
- Available ports `5800` for the browser desktop and `3211` for automation.

> **Important:** Do not run WeChat without a residential IP address.

## Get started

1. Create your local configuration:

   ```sh
   cp .env.example .env
   ```

2. Generate a private automation token:

   ```sh
   openssl rand -hex 32
   ```

   Add it to `.env`:

   ```dotenv
   CUA_ENV_TOKEN=your-generated-token
   ```

3. Start the WeChat workspace:

   ```sh
   docker compose up -d
   ```

4. Open <http://localhost:5800> and scan the QR code to sign in.

If you are accessing WeChat from another computer, replace `localhost` with the Docker host's address. Only use a trusted network or a secure tunnel.

## Connect an AI agent

Configure an MCP-compatible agent with this endpoint:

```text
http://localhost:3211/mcp
```

Use the token from `.env` as a bearer token:

```text
Authorization: Bearer <CUA_ENV_TOKEN>
```

Once connected, the agent can automate the same desktop visible in your browser. Keep the browser session available for QR-code sign-in, verification challenges, and any actions that require human approval.

## Your data

WeChat saves your login state and files in:

- `wechat/.xwechat`
- `wechat/xwechat_files`

Keep both directories to preserve your agent's workspace when updating or restarting. Back them up regularly, and stop WeChat before making a backup:

```sh
docker compose down
```

These directories contain sensitive account data and personal files. Keep them private.

## Security

The browser desktop does not include authentication or encryption. Do not expose ports `5800` or `3211` to the public internet. Use a trusted local network, firewall rules, or a secure tunnel, and keep your automation token private.

An agent operating WeChat can act through your account and access information available in the desktop session. Supervise its actions, limit access to trusted agents, and require human confirmation for sensitive operations.
