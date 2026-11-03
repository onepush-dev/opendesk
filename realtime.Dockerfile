# opendesk realtime gateway v0.4.7 (useopendesk/opendesk, Apache-2.0) for Railway, release unchanged.
# Only bakes defaults: port 4000 and one proxy hop (Railway's edge) in front.
FROM ghcr.io/useopendesk/realtime:v0.4.7@sha256:d1e16ccab5dc51efeecd58073dada1a2a17db6c822003ae99590c87b0fcf1a73
ENV PORT=4000 \
    TRUSTED_PROXY_HOPS=1
EXPOSE 4000
