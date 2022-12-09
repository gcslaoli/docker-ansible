FROM alpine:latest
ENV TZ=Asia/Shanghai
RUN apk add --no-cache \
    bash \
    curl \
    tzdata \
    python3 \
    py3-pip \
    && pip install --upgrade pip \
    && pip install --no-cache-dir \
    ansible \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/* 
