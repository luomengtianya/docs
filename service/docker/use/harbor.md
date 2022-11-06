* [官网](https://goharbor.io/docs/2.6.0/install-config/installation-prereqs/)

* 服务器最低要求  

  | 资源 | 最小  | 推荐   |
  | :--- | :---- | :----- |
  | CPU  | 2 CPU | 4 CPU  |
  | 内存 | 4 GB  | 8 GB   |
  | 硬盘 | 40 GB | 160 GB |

* 软件

  | Software       | Version                                                      | Description                                                  |
  | :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
  | Docker engine  | Version 17.06.0-ce+ or higher                                | For installation instructions, see [Docker Engine documentation](https://docs.docker.com/engine/installation/) |
  | Docker Compose | docker-compose (v1.18.0+) or docker compose v2 (docker-compose-plugin) | For installation instructions, see [Docker Compose documentation](https://docs.docker.com/compose/install/) |
  | Openssl        | Latest is preferred                                          | Used to generate certificate and keys for Harbor             |

* 安装docker/docker-compose

  * [docker](https://docs.docker.com/engine/install/centos/)

    ```shell
    yum install docker
    ```

  * [docker-compose](https://docs.docker.com/compose/install/linux/)

    ```shell
    yum install docker-compose-plugin
    ```

  * compose版本不一致的时候

    ```shell
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    sudo chmod +x /usr/local/bin/docker-compose
    
    docker-compose -v 查看版本
    ```

* 下载harbor

  * [线上下载](https://github.com/goharbor/harbor/releases)

* 解压文件

  ```shell
  tar xzvf harbor-online-installer-version.tgz
  ```

* 添加证书

  * Docker守护进程将.crt文件解释为CA证书，将.cert文件解释为客户端证书。

    ```
    openssl x509 -inform PEM -in jgaonet.com.crt -out jgaonet.com.cert
    ```

  * 添加证书信息到docker中

    ```
    cp jgaonet.com.cert /etc/docker/certs.d/jgaonet.com/
    cp jgaonet.com.key /etc/docker/certs.d/jgaonet.com/
    cp jgaonet.com.crt /etc/docker/certs.d/jgaonet.com/
    ```

  * 重启docker

    ```
    systemctl restart docker
    ```

  * 启动harbor

    ```
    ./install.sh
    ```

* 登录

  ```
  默认账号 admin/ Harbor12345  可在harbor.yaml中修改默认登录密码,字段为harbor_admin_password
  ```

  !> 启动后需要在服务内修改，修改配置文件不会生效

* 关闭harbor

  ```shell
  目录下运行
  
  docker-compose stop
  ```


* 运行问题

  * ERROR:root:Please specify hostname

    ```
    那原因是启动harbor时没有修改harbor.yml里的内容。 
    
    把配置文件中默认的hostname: reg.mydomain.com， 改为本地的ip。
    比如： hostname：10.6.119.106
    ```

  * :root:Error: The protocol is https but attribute ssl_cert is not set

    ```
    这是因为 harbor.yaml文件配置了443的端口，但是启动前却没有配置证书导致的，可以先配置证书，然后./prepare导入证书信息，再./install.sh启动
    
    # https related config
    https:
      # https port for harbor, default is 443
      port: 443
      # The path of cert and key files for nginx
      certificate: /root/ssl/jgaonet.com.crt
      private_key: /root/ssl/jgaonet.com.key
    ```


