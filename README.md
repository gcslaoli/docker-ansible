# docker-ansible

ansible docker 运行环境

- 镜像地址：[https://hub.docker.com/r/gcslaoli/ansible/](https://hub.docker.com/r/gcslaoli/ansible/)
- GitHub 地址：[https://github.com/gcslaoli/docker-ansible](https://github.com/gcslaoli/docker-ansible)

## 1. 说明

本项目是基于 docker 容器的 ansible 运行环境，主要用于 ansible 的学习和测试以及运维环境的快速搭建及标准化。

当需要同时维护多个主机集群时, 可以使用本项目来快速搭建 ansible 运行环境, 无需在本地安装 ansible。

推荐将项目配置文件和 playbook 文件放在项目目录中，然后将项目目录挂载到容器中，这样可以在容器外修改配置文件和 playbook 文件。

推荐使用 git 来管理项目, 为每个项目创建一个 repo, 这样可以方便的管理多个项目。注意 repo 中如需要存放密码等敏感信息，需要将 repo 设置为私有。

## 2. 使用

推荐使用 docker-compose 来运行容器，可以直接使用 docker-compose.yml 文件。

创建 docker-compose.yml 文件：

```yaml
version: "3"
services:
  ansible:
    image: gcslaoli/ansible:latest
    environment:
      - AUTO_SSHKEY_COMMENT=ansible # 自动生成的 ssh 密钥注释
    volumes:
      - ./:/ansible/ # 将当前目录挂载到容器的 /ansible 目录
      - ./data/.ssh:/tmp/.ssh # 将 ssh 密钥挂载到容器的 /tmp/.ssh 目录,如果本地目录为空, 将会自动生成密钥
    command: sleep infinity # 保持容器运行
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

## 3. 配置

可在 docker-compose.yml 文件同级目录下创建 ansible.cfg 文件，用于配置 ansible。

```ini
[defaults]
inventory = ./inventory.yml # 指定 inventory 文件
host_key_checking = False # 关闭 ssh 主机密钥检查
roles_path = ./roles # 指定 roles 目录
collections_paths = ./collections # 指定 collections 目录
```

## 4. 目录结构

```bash
.
├── ansible.cfg # ansible 配置文件
├── collections # collections 目录
├── data # 数据目录
│   └── .ssh # ssh 密钥目录
├── docker-compose.yml # docker-compose 配置文件
├── inventory.yml # inventory 文件
├── playbook.yml # playbook 文件
└── roles # roles 目录
```

## 5. 更新

```bash
docker-compose pull
```
