# opendesk on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/Z0b_ih)

[opendesk](https://github.com/useopendesk/opendesk) (Apache-2.0) is an open-source helpdesk: shared inbox, live-chat widget, help center, AI drafts and triage, SLAs, CSAT, REST API, webhooks and MCP.

This repo holds the Railway packaging for opendesk v0.4.7:

- `Dockerfile` → `ghcr.io/onepush-dev/opendesk:v0.4.7`: upstream `ghcr.io/useopendesk/opendesk:v0.4.7` (pinned by digest), binary unchanged. Runs as root so it can write the Railway volume at `/data`, embedded NATS listens on `[::]:4222` for the gateway over the private network, and Railway defaults (production, web app served, local storage, log mailer, one proxy hop) are baked in.
- `realtime.Dockerfile` → `ghcr.io/onepush-dev/opendesk-realtime:v0.4.7`: upstream realtime gateway (pinned by digest), release unchanged; `PORT=8080`, `TRUSTED_PROXY_HOPS=1`.

Services: opendesk (web app + API, volume `/data`), realtime (Phoenix socket gateway on its own domain, `GATEWAY_URL=wss://<realtime domain>/socket`), Postgres (`pgvector/pgvector:pg17`).

Template variables (all generated or referenced, zero inputs): opendesk `AUTH_SECRET` (secret, shared with realtime), `CREDENTIALS_KEY` (64 hex chars), `NATS_TOKEN` (shared with realtime), `INBOUND_SECRET`, `DATABASE_URL` (Postgres reference), `API_URL`/`APP_URL`/`SITE_URL`/`CORS_ORIGINS` (`https://${{RAILWAY_PUBLIC_DOMAIN}}`), `GATEWAY_URL` (`wss://${{realtime.RAILWAY_PUBLIC_DOMAIN}}/socket`), `MAIL_FROM`; realtime `SECRET_KEY_BASE`, `NATS_URL` (`nats://${{opendesk.RAILWAY_PRIVATE_DOMAIN}}:4222`), `PHX_HOST`, `CHECK_ORIGINS`; Postgres `POSTGRES_PASSWORD`.

After deploy: open the opendesk URL, sign up (the first account creates its workspace), then connect a mailbox (forwarding, IMAP/SMTP, or Google/Microsoft OAuth), add the chat widget, and optionally set `ANTHROPIC_API_KEY` or `OPENAI_API_KEY` for the AI features and `MAIL_DRIVER=smtp` + `SMTP_*` for platform email. Set `SIGNUP_ENABLED=false` once your team has joined.
