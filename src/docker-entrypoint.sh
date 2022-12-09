#!/bin/sh
set -e
echo "Starting docker-entrypoint.sh script with PID $$ at $(date) ..."
# 如果 /tmp/.ssh 目录存在，就将其拷贝到 /root/.ssh 目录下
if [ -d "/tmp/.ssh" ]; then
    cp -r /tmp/.ssh /root/.ssh
    chmod 700 /root/.ssh
fi
# 如果 id_rsa 存在,配置权限
if [ -f /root/.ssh/id_rsa ]; then
    chmod 600 /root/.ssh/id_rsa
fi
# 如果 id_rsa.pub 存在,配置权限
if [ -f /root/.ssh/id_rsa.pub ]; then
    chmod 644 /root/.ssh/id_rsa.pub
fi

# 如果 /root/.ssh/id_rsa 不存在，就生成一个
if [ ! -f /root/.ssh/id_rsa ]; then
    echo "Generating SSH key..."
    echo "AUTO_SSHKEY_COMMENT=$AUTO_SSHKEY_COMMENT"
    ssh-keygen -t rsa -f /root/.ssh/id_rsa  -C "$AUTO_SSHKEY_COMMENT" -N ''
    echo "Generated SSH key:"
    cat /root/.ssh/id_rsa.pub
    # 复制到 /tmp/.ssh 目录下
    cp /root/.ssh/id_rsa /tmp/.ssh/id_rsa
    cp /root/.ssh/id_rsa.pub /tmp/.ssh/id_rsa.pub
    echo "Copied SSH key to /tmp/.ssh"
fi

echo "... docker-entrypoint.sh script completed with PID $$ at $(date) ..."
exec "$@"
