## 什么是Docker

Docker是开发、发布和运行应用程序的开放平台。Docker使您能够将应用程序从基础设施中分离出来，以便快速交付软件。使用Docker，您可以以管理应用程序的相同方式管理基础设施。通过利用Docker快速发布、测试和部署代码的方法，可以显著减少编写代码和在生产环境中运行代码之间的延迟。

## Docker能够做什么

* 快速、一致的应用程序交付

  Docker允许开发人员使用提供应用程序和服务的本地容器在标准化的环境中工作，从而简化了开发生命周期。容器非常适合持续集成和持续交付(CI/CD)工作流程。

  考虑以下示例场景:

  	1、开发人员在本地编写代码，并使用Docker容器与同事共享他们的工作。
  	2、他们使用Docker将应用程序推入测试环境并执行自动和手动测试。
  	3、当开发人员发现错误时，他们可以在开发环境中修复它们，并将它们重新部署到测试环境中进行测试和验证。
  	4、测试完成后，向客户提供修复程序就像将更新后的映像推送到生产环境一样简单。
  
* 响应式部署和扩展

  Docker基于容器的平台允许高度可移植的工作负载。Docker容器可以在开发人员的本地笔记本电脑上运行，也可以在数据中心的物理或虚拟机上运行，也可以在云提供商上运行，或者在混合环境中运行。

  Docker的可移植性和轻量级特性也使得它很容易动态管理工作负载，根据业务需要扩展或删除应用程序和服务，几乎是实时的。

* 在相同的硬件上运行更多的工作负载

  Docker重量轻，速度快。它为基于管理程序的虚拟机提供了一种可行的、具有成本效益的替代方案，因此您可以使用更多的服务器容量来实现业务目标。Docker非常适合高密度环境以及需要用更少资源做更多事情的中小型部署。
  

##  Docker体系架构

Docker使用`客户端-服务器`架构。Docker客户端与`Docker daemo通信，后者负责构建、运行和分发Docker容器的繁重工作。Docker客户端和守护进程可以运行在同一个系统上，或者可以将Docker客户端连接到远程Docker守护进程。Docker客户端和守护进程使用REST API通过UNIX Socket或网络接口进行通信。另一个Docker客户端是Docker Compose，它允许您处理由一组容器组成的应用程序。

![Docker Architecture Diagram](docker.assets/architecture.svg)



* Docker服务组件

| 名称       | 解释     | 作用                                                         |
| ---------- | :------- | ------------------------------------------------------------ |
| daemon     | 守护进程 | Docker守护进程(dockerd)监听Docker API请求并管理Docker对象，如映像、容器、网络和卷。一个守护进程还可以与其他守护进程通信来管理Docker服务。 |
| client     | 客户端   | Docker客户端(Docker)是许多Docker用户与Docker交互的主要方式。当您使用诸如docker run这样的命令时，客户端将这些命令发送给dockerd, dockerd将执行这些命令。docker命令使用docker API。Docker客户机可以与多个守护进程通信。 |
| Desktop    | 桌面程序 | Docker Desktop是一个易于安装的应用程序，适用于您的Mac、Windows或Linux环境，它使您能够构建和共享容器化的应用程序和微服务。Docker桌面包括Docker守护进程(dockerd)、Docker客户端(Docker)、Docker Compose、Docker Content Trust、Kubernetes和Credential Helper。 |
| registries | 仓库     | 储存Docker镜像的仓库。Docker Hub是一个任何人都可以使用的公共注册中心，默认情况下，Docker被配置为在Docker Hub上查找镜像。你甚至可以运行自己的私人镜像仓库，如harbor。可以使用`docker pull`下载，`docker push` 上传镜像。 |

* Docker应用组件

| 名称       | 解释     | 作用                                                         | 备注 |
| ---------- | -------- | :----------------------------------------------------------- | ---- |
| Images     | 镜像     | 镜像是一个只读模板，带有创建Docker容器的说明。通常，一个镜像基于另一个镜像，并进行了一些额外的定制。要构建您自己的镜像，您需要创建一个Dockerfile，该Dockerfile使用一个简单的语法来定义创建和运行镜像所需的步骤。Dockerfile中的每条指令都在镜像中创建一个层。当您更改Dockerfile并重新构建镜像时，只有那些更改过的层才会重新构建。 |      |
| Containers | 容器     | 容器是镜像的可运行实例。您可以使用Docker API或CLI创建、启动、停止、移动或删除容器。您可以将容器连接到一个或多个网络，向其附加存储，甚至根据其当前状态创建新镜像。默认情况下，容器与其他容器及其主机相对隔离。您可以控制容器的网络、存储或其他底层子系统与其他容器或主机的隔离程度。 |      |
| Networks   | 网络     | 默认情况下，容器是独立运行的，不了解同一机器上的其他进程或容器。Networks允许一个容器与另一个容器通信。使用 `docker network create {network}`创建新网络 |      |
| Volumes    | 挂载/卷  | 卷提供了将容器的特定文件系统路径连接回主机的能力。如果挂载容器中的一个目录，则在主机上也可以看到该目录中的更改。如果我们在重新启动容器时挂载同一个目录，我们将看到相同的文件，此方式使用 `-v` 的方式挂载。另外可以使用 `docker volume create todo-db`的方式创建一个挂载 `sqlite`数据库挂载(默认，地址：/etc/todos/todo.db) |      |
| Plugins    | 插件     |                                                              |      |
| Other      | 其他组件 |                                                              |      |

* network示例


```shell
docker run -d \
  --network todo-app --network-alias mysql \
  --platform "linux/amd64" \
  -v todo-mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=secret \
  -e MYSQL_DATABASE=todos \
  mysql:5.7
```

使用`--network-alias`可以让其它同网络的服务按照此别名进行访问

!> 如果你使用的是基于ARM的芯片，例如Macbook M1芯片/ Apple Silicon，那么使用`--platform "linux/amd64"`这个命令。

```shell
 docker run -dp 3000:3000 \
   -w /app -v "$(pwd):/app" \
   --network todo-app \
   -e MYSQL_HOST=mysql \
   -e MYSQL_USER=root \
   -e MYSQL_PASSWORD=secret \
   -e MYSQL_DB=todos \
   node:12-alpine \
   sh -c "yarn install && yarn run dev"
```

连接到mysql数据库。

```shell
docker exec -it <mysql-container-id> mysql -p todos
```

## Docker Compose

Docker Compose是一个帮助定义和共享多容器应用程序的工具。通过使用Compose，我们可以创建一个YAML文件来定义服务，并且通过一个命令就可以将所有内容进行运转或删除。

### 安装 Docker Compose

如果您为Windows或Mac安装了Docker桌面/工具箱，那么您已经有了Docker Compose。如果您使用的是Linux机器，则需要安装Docker Compose。安装之后，您应该能够运行以下程序并查看版本信息。

```shell
docker compose version
```

### 使用 Docker Compose 

* 在项目的根目录添加 `docker-compose.yml` 文件

* 启动示例

```shell
docker run -dp 3000:3000 \
  -w /app -v "$(pwd):/app" \
  --network todo-app \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=secret \
  -e MYSQL_DB=todos \
  node:12-alpine \
  sh -c "yarn install && yarn run dev"
```

```shell
docker run -d `
  --network todo-app --network-alias mysql `
  -v todo-mysql-data:/var/lib/mysql `
  -e MYSQL_ROOT_PASSWORD=secret `
  -e MYSQL_DATABASE=todos `
  mysql:5.7
```

* 转换数据 `docker-compose.yml`

```
version: "3.7"

services:
  app:
    image: node:12-alpine
    command: sh -c "yarn install && yarn run dev"
    ports:
      - 3000:3000
    working_dir: /app
    volumes:
      - ./:/app
    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: root
      MYSQL_PASSWORD: secret
      MYSQL_DB: todos

  mysql:
    image: mysql:5.7
    volumes:
      - todo-mysql-data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: todos

volumes:
  todo-mysql-data:
```

!> 当我们用docker run运行容器时，命名卷会自动创建。但是，在使用Compose运行时不会发生这种情况。我们需要在顶层volumes:节中定义卷，然后在服务配置中指定挂载点。通过只提供卷名，可以使用默认选项。

* 使用`docker compose up`命令启动应用程序堆栈。我们将添加`-d`标志以在后台运行所有内容。

!> 默认情况下，Docker Compose会自动为应用程序栈创建一个专门的网络

* 使用`docker compose logs -f`查看项目日志 `-f` 是持续输出；想看单独的日志使用 `docker compose logs -f app`

* 使用 `docker compose down` 移除所有的程序。


!> 默认情况下，当运行docker compose down时，你的compose文件中的命名卷不会被删除。如果你想删除卷，你需要添加`——volumes`标志。

* 想要停止运行的程序，执行 `docker compose stop` ，启动时使用 `docker compose start`



## 配置容器网络

### network详情

使用`docker network ls`可以查看本地docker配置的网络

| 名称                                                         | 作用                                                         |      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| bridge                                                       | 默认的网络驱动程序。如果您没有指定驱动程序，这就是您要创建的网络类型。当应用程序在需要通信的独立容器中运行时，通常使用桥接网络。看到桥网络。 |      |
| host                                                         | 对于独立的容器，取消容器和Docker主机之间的网络隔离，并直接使用主机的网络。 |      |
| overlay                                                      | overlay网络将多个Docker守护进程连接在一起，实现集群服务之间的通信。您还可以使用覆盖网络来促进群集服务和独立容器之间的通信，或者促进不同Docker守护进程上的两个独立容器之间的通信。这种策略消除了在这些容器之间进行操作系统级路由的需要。 |      |
| ipvlan                                                       | ipvlan网络为用户提供对IPv4和IPv6寻址的完全控制。VLAN驱动建立在此基础之上，为对底层网络集成感兴趣的用户提供对第二层VLAN标记甚至IPvlan L3路由的完全控制。 |      |
| macvlan                                                      | macvlan网络允许为容器分配MAC地址，使其在网络中显示为物理设备。Docker守护进程通过容器的MAC地址将流量路由到容器。当处理期望直接连接到物理网络而不是通过Docker主机的网络堆栈路由的遗留应用程序时，使用macvlan驱动程序有时是最佳选择。 |      |
| none                                                         | 对于该容器，禁用所有网络。通常与自定义网络驱动程序一起使用。无。集群服务无。 |      |
| [Network plugins](https://docs.docker.com/engine/extend/plugins_services/) | 您可以使用Docker安装和使用第三方网络插件。这些插件可从 [Docker Hub](https://hub.docker.com/search?category=network&q=&type=plugin) 或第三方供应商获得。 |      |



### 容器发布端口

| 标记变量                        | Description                                                  |
| :------------------------------ | :----------------------------------------------------------- |
| `-p 8080:80`                    | 路由 TCP 端口 80 到Docker主机上容器的端口 8080 上.           |
| `-p 192.168.1.100:8080:80`      | 路由 TCP 端口 80 到Docker主机ip:192.168.1.100、容器的端口 8080 上. |
| `-p 8080:80/udp`                | 路由 UDP 端口 80 到Docker主机上容器的端口 8080 上.           |
| `-p 8080:80/tcp -p 8080:80/udp` | 路由 TCP 端口 80 到Docker主机上的 TCP 端口 8080 上； 路由 UDP 端口 80 到Docker主机上的 UDP 端口 8080 上. |

默认情况下，容器为它连接到的每个Docker网络分配一个IP地址。IP地址是从分配给网络的池中分配的，因此Docker守护进程有效地充当每个容器的DHCP服务器。每个网络也有一个默认的子网掩码和网关。

当容器启动时，它只能使用`--network`连接到单个网络。但是，您可以使用docker网络连接将运行中的容器连接到多个网络。当你使用`--network`标志启动一个容器时，你可以使用`--IP`或`--ip6`标志指定分配给该网络上容器的IP地址。

当您使用docker网络连接现有容器到不同的网络时，您可以在该命令上使用`--ip`或`--ip6`标志来指定容器在附加网络上的ip地址。

同样，容器的主机名默认为Docker中的容器ID。您可以使用`--hostname`来覆盖主机名。当使用docker网络连接到现有网络时，可以使用`--alias`标志为该网络上的容器指定额外的网络别名。

* 给运行中的容器连接网络

```shell
docker network connect {network} {container}
```

* 给运行中的容器移除网络

```shell
docker network disconnect {network} {container}
```

