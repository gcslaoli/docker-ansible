# docker-ansible

ansible docker 运行环境

镜像地址：[https://hub.docker.com/r/gcslaoli/ansible/](https://hub.docker.com/r/gcslaoli/ansible/)

## 1. 说明

本项目是基于 docker 容器的 ansible 运行环境，主要用于 ansible 的学习和测试。

## 2. 使用

推荐使用 docker-compose 来运行容器，可以直接使用 docker-compose.yml 文件。

创建 docker-compose.yml 文件：

```yaml
version: "3"
services:
  ansible:
    image: gcslaoli/ansible:dev
    container_name: ansible
    volumes:
      - ./:/ansible/ # 将当前目录挂载到容器的 /ansible 目录
```

启动容器：

```bash
docker-compose run --rm ansible bash
```

命令将会进入容器的 bash 环境，可以在容器中执行 ansible 命令。

```bash
ansible --version
```

退出容器：

```bash
exit
```
TIP: 退出容器后，容器将会被删除。如果不想删除容器, 可以使用 `docker-compose up -d` 命令启动容器。启动后，可以使用 `docker-compose exec ansible bash` 命令进入容器。

清理容器：

```bash
docker-compose down
```

## 3. 目录结构

```bash
.
├── README.md
├── docker-compose.yml
├── hosts
└── playbook.yml
```