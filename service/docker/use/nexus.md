!> *maven*的私有仓库

* [资源地址](https://hub.docker.com/r/sonatype/nexus3)

* 搜索 nexus 镜像

  ```shell
  docker search nexus3
  ```

* 拉去 nexus 镜像

  ```shell
  docker pull sonatype/nexus3
  ```

* 启动仓库

  ```shell
  $ docker run -d -p 8081:8081 --name nexus sonatype/nexus3
  ```

* 挂载外部路径启动

  ```shell
  docker volume create --name nexus-data
  mkdir -p /var/local/nexus-data && chown -R 200 /var/local/nexus-data
  docker run -d -p 8081:8081 --name nexus -v /var/local/nexus-data:/nexus-data --restart=always sonatype/nexus3
  ```

* 获取日志

  ```shell
  docker logs -f --tail 20 nexus
  ```

* 账号

  ```
  admin
  ```

  !>  初始密码在 /var/loval/nexus-data/admin.password 文件中，修改密码后就被删除了

