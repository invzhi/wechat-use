FROM debian:trixie-slim AS build

# Install dependencies.
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		gzip \
		libx11-6 \
		libxi6 \
		libxkbcommon-x11-0

# Install cua-spacesd.
RUN set -eux; \
	arch="$(dpkg --print-architecture)"; arch="${arch##*-}"; \
	case "$arch" in \
		'amd64') \
			url='https://github.com/trycua/cua/releases/download/cua-spacesd-v0.16.1/cua-spacesd-linux-x86_64.tar.gz'; \
			;; \
		'arm64') \
			url='https://github.com/trycua/cua/releases/download/cua-spacesd-v0.16.1/cua-spacesd-linux-aarch64.tar.gz'; \
			;; \
	esac; \
	curl -fL -o /tmp/cua-spacesd.tar.gz "$url"; \
	tar -xzf /tmp/cua-spacesd.tar.gz -C /usr/local/bin cua-spacesd; \
	rm /tmp/cua-spacesd.tar.gz

ENTRYPOINT [ "cua-spacesd" ]
