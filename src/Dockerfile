FROM alpine:latest
ENV TZ=Asia/Shanghai
WORKDIR /ansible
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache \
    bash \
    curl \
    tzdata \
    openssh \
    python3 \
    py3-pip \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --upgrade pip \
    && pip install --no-cache-dir \
    ansible \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/* 
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]