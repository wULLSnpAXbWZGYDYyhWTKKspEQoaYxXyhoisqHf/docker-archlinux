FROM archlinux:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Hourly updated archlinux base image"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://git.dotya.ml/wanderer/docker-archlinux.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license=GPL-3.0

# WORKAROUND for glibc 2.33 and old Docker
# See https://github.com/actions/virtual-environments/issues/2658
# Thanks to https://github.com/lxqt/lxqt-panel/pull/1562
ENV patched_glibc glibc-linux4-2.33-4-x86_64.pkg.tar.zst
RUN curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"
RUN pacman --version

RUN pacman -Syu --ignore glibc --noconfirm --needed
RUN pacman --noconfirm -Rn $(pacman -Qdtq) || true
RUN pacman -Scc && rm -rfv /var/cache/pacman/* /var/lib/pacman/sync/* \
    rm -rv /tmp/* || true
