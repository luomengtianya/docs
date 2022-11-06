###  安装Mysql

* 安装
  * docker search mysql 查看版本后 docker pull mysql:latest 安装最新版本
  * 到 [mysql镜像](https://hub.docker.com/_/mysql?tab=tags&page=1&ordering=last_updated) 查看镜像版本，然后`docker pull mysql:5.6.51`安装指定版本

* 启动
  * $ docker run -itd --name mysql --restart=always -p 3306:3306 -e MYSQL_ROOT_PASSWORD={password} mysql:5.6.51

```
    -p 3306:3306 ：映射容器服务的 3306 端口到宿主机的 3306 端口，外部主机可以直接通过 宿主机ip:3306 访问到 MySQL 的服务。
    MYSQL_ROOT_PASSWORD={password}：设置 MySQL 服务 root 用户的密码。
    :5.6.51 指定启动版本，不然会自动下载最新版本然后启动 \ 或者把mysql:5.6.51修改成镜像ID
```



###  使用Mysql

* 导入sql文件数据到mysql中
  * 将用户目录下的sql文件复制到容器中

```shell script
sudo docker cp ~/{{sqlname}}.sql {{mysql server name}}:{{sqlname}}.sql
```

  * 进入容器中

```shell script
docker exec -it {{mysql server name}} /bin/bash
```

  * 查看是否成功导入文件

```shell script
ls -l {{sqlname}}.sql
```

  * 连接mysql服务

```shell script
mysql -u root -p
```

  * 执行sql文件

```shell script
source {{sqlname}}.sql
```

