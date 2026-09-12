FROM node:20-alpine

# Ohne UTF-8-Locale stellen Bash/tmux/Claude Umlaute und Unicode-Symbole
# (z. B. Listen-Bullets) fehlerhaft als "_" dar. musl unterstuetzt C.UTF-8
# nativ, ohne dass zusaetzliche Locale-Pakete installiert werden muessen.
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN ALPINE_VER=$(cut -d. -f1,2 /etc/alpine-release) \
    && apk add --no-cache \
       --repository="https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/community" \
       ttyd bash tmux

RUN npm install -g @anthropic-ai/claude-code

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 7681

CMD ["/run.sh"]
