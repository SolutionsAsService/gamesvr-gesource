# Derived GoldenEye: Source image with a real entrypoint, for platforms that
# deploy an image without a run command (the stock image's CMD is /bin/bash).
# Built and pushed by .github/workflows/devhub-image.yml to
# ghcr.io/solutionsasservice/gamesvr-gesource:latest.
ARG BASE_IMAGE=ghcr.io/lacledeslan/gamesvr-gesource:latest
FROM ${BASE_IMAGE}

# The base image declares ONBUILD USER root, so we are root here.
COPY --chown=root:root --chmod=0755 dist/linux/devhub-entrypoint.sh /usr/local/bin/devhub-entrypoint.sh

LABEL org.opencontainers.image.source="https://github.com/SolutionsAsService/gamesvr-gesource" \
      org.opencontainers.image.description="GoldenEye: Source dedicated server (LacledesLAN stock image) with an env-driven entrypoint" \
      org.opencontainers.image.licenses="Unlicense"

ENV GES_MAP=ge_archives GES_MAXPLAYERS=16

EXPOSE 27015/udp

USER GESource
WORKDIR /app

ENTRYPOINT ["/usr/local/bin/devhub-entrypoint.sh"]
CMD []
