## npm

### npm使用简写

```t
在使用 npm install 命令时，有许多指定参数的命令是可以进行缩写的，本文就简单梳理一下。

npm install本身有一个别名，即npm i，可以使用这种缩写方式来运行命令，打到简化的效果。

以下为指定的一些命令行参数的缩写方式：

-g
--global，缩写为-g，表示安装包时，视作全局的包。安装之后的包将位于系统预设的目录之下，一般来说

-S
--save，缩写为-S，表示安装的包将写入package.json里面的dependencies。

-D
--save-dev，缩写为-D，表示将安装的包将写入packege.json里面的devDependencies。

-O
--save-optional缩写为-O，表示将安装的包将写入packege.json里面的optionalDependencies。

-E
--save-exact缩写为-E，表示安装的包的版本是精确指定的。

-B
--save-bundle缩写为-B，表示将安装的包将写入packege.json里面的bundleDependencies。
```



### 安装docsify没有权限 

```
Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules/docsify
```

* 思路一(提权)
  * 提升用户目录权限 `sudo chown -R $USER /usr/local/lib/node_modules`
  * 提升执行权限 `sudo npm i docsify-cli -g`

* 思路二(换目录)

  ```shell
  # 创建目录
  mkdir ~/.npm-global
  
  # 更行npm目录
  npm config set prefix '~/.npm-global'
  
  # 设置全局变量
  echo export PATH=~/.npm-global/bin:$PATH >> ~/.bash_profile
  
  # 若是使用的zsh，全局变量设置到 ~/.zshrc文件中
  
  ```

  

## nodejs

### 服务一直运行

#### 方法一、利用 forever

forever是一个nodejs守护进程，完全由命令行操控。forever会监控nodejs服务，并在服务挂掉后进行重启。

1、安装 

```shell
npm install forever -g
```

2、启动服务 

```shell
service forever start
```

3、使用 forever 启动 js 文件

```shell
forever start index.js
```

4、停止 js 文件

```shell
forever stop index.js
```

5、启动js文件并输出日志文件

```shell
forever start -l forever.log -o out.log -e err.log index.js
```

6、重启js文件

```shell
forever restart index.js
```

7、查看正在运行的进程

```shell
forever list
```



#### 方法二、利用pm2

pm2是一个进程管理工具,可以用它来管理你的[node](https://so.csdn.net/so/search?q=node&spm=1001.2101.3001.7020)进程,并查看node进程的状态,当然也支持性能监控,进程守护,负载均衡等功能
```
npm install -g pm2
pm2 start app.js // 启动
pm2 start app.js -i max //启动 使用所有CPU核心的集群
pm2 stop app.js // 停止
pm2 stop all // 停止所有
pm2 restart app.js // 重启
pm2 restart all // 重启所有
pm2 delete app.js // 关闭
```

####  方法三、利用nodejs 自带node.js自带服务nohub，不需要安装别的包


缺点：存在无法查询日志等问题,关闭终端后服务也就关闭了， 经测试是这样的。

nohup node ***.js &