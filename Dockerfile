# syntax=docker/dockerfile:1.3
# refs:
#   https://docs.docker.com/develop/develop-images/build_enhancements/#overriding-default-frontends
#   https://pythonspeed.com/articles/docker-buildkit/

FROM docker.io/library/archlinux:base-devel

ARG BUILD_DATE
ARG VCS_REF

# as per https://github.com/opencontainers/image-spec/blob/main/annotations.md,
# keep Label Schema labels for backward compatibility.
LABEL description="hourly updated archlinux base(-devel) image" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://git.dotya.ml/wanderer/docker-archlinux.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license=GPL-3.0 \
      org.opencontainers.image.title="docker-archlinux" \
      org.opencontainers.image.description="hourly updated archlinux base(-devel) image" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors=wanderer \
      org.opencontainers.image.url="https://git.dotya.ml/wanderer/docker-archlinux.git" \
      org.opencontainers.image.source="https://git.dotya.ml/wanderer/docker-archlinux.git" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.licenses=GPL-3.0

# if you need the WORKAROUND for glibc 2.33 and old Docker
# have a look at https://git.dotya.ml/wanderer/docker-archlinux/commit/bd4c5abe4dca475965548cb8332ef9b9d2a4953c

RUN pacman --version && \
	\
	\
	pacman -Syu --noconfirm --needed && \
	pacman --noconfirm -Rn "$(pacman -Qdtq)" || true && \
	pacman -Scc && rm -rf /var/cache/pacman/* /var/lib/pacman/sync/*
