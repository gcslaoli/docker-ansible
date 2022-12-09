FROM ubuntu:22.04
ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /cloud-deploy
RUN sed -i "s@http://archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://ports.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && apt-get update && apt-get install -y python3-pip tzdata ssh\
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --no-cache-dir ansible \
    && pip install --no-cache-dir argcomplete \
    && mkdir -p /etc/bash_completion.d \
    && activate-global-python-argcomplete \
    && apt-get clean 
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]