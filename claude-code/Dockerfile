FROM node:20-alpine

RUN ALPINE_VER=$(cut -d. -f1,2 /etc/alpine-release) \
    && apk add --no-cache \
       --repository="https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/community" \
       ttyd bash

RUN npm install -g @anthropic-ai/claude-code

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 7681

CMD ["/run.sh"]
