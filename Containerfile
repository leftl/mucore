FROM scratch as builder
COPY tree/ /
COPY build.sh /tmp
COPY cosign.pub /tmp/signing

FROM ghcr.io/ublue-os/ucore:stable
COPY --from=builder / /
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    /tmp/signed-repo.sh && \
    /tmp/cleanup.sh && \
    ostree container commit
