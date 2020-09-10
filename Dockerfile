# Build a custom caddy image.
FROM caddy:2.1.1-builder AS builder

# Build a new caddy entrypoint with the provided modules.
RUN caddy-builder \
    github.com/caddy-dns/cloudflare \
    github.com/lucaslorentz/caddy-docker-proxy/plugin/v2

# Build on the standard caddy image.
FROM caddy:2.1.1

# Copy the new entrypoint into it for a much smaller final image.
COPY --from=builder /usr/bin/caddy /usr/bin/caddy