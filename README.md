# opendesk on Railway

[opendesk](https://github.com/useopendesk/opendesk) (Apache-2.0) is an open-source helpdesk: shared inbox, live-chat widget, help center, AI drafts and triage, SLAs, CSAT, REST API, webhooks and MCP.

This repo holds the Railway packaging for opendesk v0.4.7:

- `Dockerfile` → `ghcr.io/onepush-dev/opendesk:v0.4.7`: upstream `ghcr.io/useopendesk/opendesk:v0.4.7` (pinned by digest), binary unchanged. Runs as root so it can write the Railway volume at `/data`, embedded NATS listens on `[::]:4222` for the gateway over the private network, and Railway defaults (production, web app served, local storage, log mailer, one proxy hop) are baked in.
- `realtime.Dockerfile` → `ghcr.io/onepush-dev/opendesk-realtime:v0.4.7`: upstream realtime gateway (pinned by digest), release unchanged; `PORT=4000`, `TRUSTED_PROXY_HOPS=1`.

Services: opendesk (web app + API, volume `/data`), realtime (Phoenix socket gateway on its own domain, `GATEWAY_URL=wss://<realtime domain>/socket`), Postgres (`pgvector/pgvector:pg17`).
