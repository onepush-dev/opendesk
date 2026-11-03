# opendesk v0.4.7 (useopendesk/opendesk, Apache-2.0) for Railway: the upstream image, binary unchanged.
# Changes: runs as root so it can write to the Railway volume at /data (mounted root-owned),
# and bakes the Railway-specific defaults that would otherwise be plain template variables.
FROM ghcr.io/useopendesk/opendesk:v0.4.7@sha256:e4135f0e533df5e2d921f481e31004445d8f474b01f24e78f6a9834980e4d617
USER 0:0
ENV OPENDESK_ENV=production \
    OPENDESK_ROLE=all \
    SERVE_WEB=true \
    HTTP_ADDR=:8080 \
    DATA_DIR=/data \
    NATS_LISTEN=[::]:4222 \
    STORAGE_DRIVER=local \
    MAIL_DRIVER=log \
    TRUST_PROXY=false \
    TRUSTED_PROXY_HOPS=1 \
    SIGNUP_ENABLED=true \
    UPDATE_CHECK=true \
    LOG_LEVEL=info
EXPOSE 8080 4222
ENTRYPOINT ["/opendesk"]
CMD ["serve"]
