FROM archlinux:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Hourly updated archlinux base image"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://git.dotya.ml/wanderer/docker-archlinux.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license=GPL-3.0

WORKDIR /tmp/
RUN pacman -Syu --noconfirm --needed && pacman --noconfirm -R $(pacman -Qdtq) || true
RUN pacman -Scc && rm -rfv /var/cache/pacman/* /var/lib/pacman/sync/* \
    rm -rv /tmp/* || true
WORKDIR /
