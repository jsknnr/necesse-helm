FROM debian:12-slim

ENV DEBIAN_FRONTEND "noninteractive"
ENV NECESSE_PATH "/home/steam/necesse"
ENV STEAMCMD_PATH "/home/steam/steamcmd"
ENV PERSISTENT_PATH "/home/steam/.config"

RUN groupadd -g 1000 steam \
    && useradd -g 1000 -u 1000 -m steam \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
        curl \
        ca-certificates-java \
        openjdk-17-jre-headless \
        lib32gcc-s1 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y

USER steam

RUN mkdir "$NECESSE_PATH" \
    && mkdir "$STEAMCMD_PATH" \
    && curl -sqL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zxvf - -C "$STEAMCMD_PATH" \
    && chmod +x "$STEAMCMD_PATH"/steamcmd.sh \
    && mkdir "$PERSISTENT_PATH"
    
ADD entrypoint.sh /home/steam/entrypoint.sh

WORKDIR /home/steam

CMD ["/home/steam/entrypoint.sh"]
