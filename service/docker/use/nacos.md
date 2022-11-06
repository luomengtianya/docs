

* 编译源码

```shell
mvn -Prelease-nacos -Dmaven.test.skip=true clean install -U
```

* 执行sql文件，创建库

* 修改配置文件

* 启动(单机)

  ```shell
  sh startup.sh -m standalone
  ```

* 访问地址  :8848/nacos

* 默认账号密码 nacos/nacos

* nacos开启鉴权

  ```properties
  nacos.core.auth.enabled=true
  ```

* 鉴权访问

  ```java
  String serverAddr = "{serverAddr}";
  Properties properties = new Properties();
  properties.put("serverAddr", serverAddr);
  properties.put("username","nacos-readonly");
  properties.put("password","nacos");
  ConfigService configService = NacosFactory.createConfigService(properties);
  ```

  

* docker启动 

  ```shell
  docker run \
  --name nacos-standalone \
  -e MODE=standalone \
  -e SPRING_DATASOURCE_PLATFORM=mysql \
  -e MYSQL_SERVICE_HOST={host} \
  -e MYSQL_SERVICE_PORT={port} \
  -e MYSQL_SERVICE_DB_NAME=nacos_config \
  -e MYSQL_SERVICE_USER=root \
  -e MYSQL_SERVICE_PASSWORD={password} \
  -e NACOS_AUTH_ENABLE=true \
  -p 8848:8848 -d \
  -p 9848:9848  \
  nacos/nacos-server:latest
  ```

  

* 添加nginx

  ```shell
  docker run --name nginx-common --link nacos-standalone -v /root/nginx/nginx.conf:/etc/nginx/nginx.conf -v /root/ssl/jgaonet.com.crt:/etc/cert/server.crt -v /root/ssl/jgaonet.com.key:/etc/cert/server.key -p 443:443 -d -p 80:80 nginx:latest
  ```

  



