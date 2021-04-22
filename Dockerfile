# syntax=docker/dockerfile:1.2
# refs:
#   https://docs.docker.com/develop/develop-images/build_enhancements/#overriding-default-frontends
#   https://pythonspeed.com/articles/docker-buildkit/

FROM archlinux:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Hourly updated archlinux base image"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://git.dotya.ml/wanderer/docker-archlinux.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license=GPL-3.0

# if you need the WORKAROUND for glibc 2.33 and old Docker
# have a look at https://git.dotya.ml/wanderer/docker-archlinux/commit/bd4c5abe4dca475965548cb8332ef9b9d2a4953c

RUN pacman --version

RUN pacman -Syu --noconfirm --needed
RUN pacman --noconfirm -Rn "$(pacman -Qdtq)" || true
RUN pacman -Scc && rm -rf /var/cache/pacman/* /var/lib/pacman/sync/*
