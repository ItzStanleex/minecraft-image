FROM --platform=$TARGETOS/$TARGETARCH debian:bookworm-slim

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends wget apt-transport-https gpg ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings \
    && wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb bookworm main" > /etc/apt/sources.list.d/adoptium.list

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        temurin-21-jdk \
        lsof curl openssl git tar sqlite3 \
        fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
    && apt-get purge -y wget apt-transport-https gpg \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY --chown=container:container --chmod=755 entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
