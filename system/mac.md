## mac软件关闭开机自启

* macOS 系统的启动项会以 .plist 的文件存在于以下目录中

  - `/Library/LaunchDaemons`：系统启动时运行，用户不登录也会运行。

  - `/Library/LaunchAgents`：用户登录后运行。

  - `~/Library/LaunchAgents`：用户自定义的用户启动项

  - `/System/Library/LaunchDaemons`：系统自带的启动项

  - `/System/Library/LaunchAgents`：系统自带的启动项


* 每个 .plist 文件中，有 3 个属性控制着是否会开机自动启动

  - `KeepAlive`：决定程序是否需要一直运行，如果是 false 则需要时才启动。默认 false

  - `RunAtLoad`：开机时是否运行。默认 false。

  - `SuccessfulExit`：此项为 true 时，程序正常退出时重启（即退出码为 0）；为 false 时，程序非正常退出时重启。此项设置时会隐含默认 RunAtLoad = true，因为程序需要至少运行一次才能获得退出状态。


* 所以其实针对这三项，不同的值有不同的表现
  - 如果 `KeepAlive` = false：
  - 当 `RunAtLoad` = false 时：程序只有在有需要的时候运行。
  - 当 `RunAtLoad` = true 时：程序在启动时会运行一次，然后等待在有需要的时候运行。
  - 当 `SuccessfulExit` =  true / false 时：不论 `RunAtLoad` 值是什么，都会在启动时运行一次。其后根据 `SuccessfulExit` 值来决定是否重启。 
  - 如果 `KeepAlive` = true ：
  - 不论 `RunAtLoad`/`SuccessfulExit` 值是什么，都会启动时运行且一直保持运行状态。

* 如果不希望开机自动运行，则需要

> 1. 找到对应程序的 .plist 文件 
> 2. 删除 SuccessfulExit 属性。
> 3. 将 RunAtLoad / KeepAlive 均设为 `<false/>`



## 卸载java

* 输入（请勿尝试通过从 /usr/bin 删除 Java 工具来卸载 Java。此目录是系统软件的一部分，下次对操作系统执行更新时，Apple 会重置所有更改）：

```shell
sudo rm -rf ~/Library/Internet Plug-Ins/JavaAppletPlugin.plugin

sudo rm -rf ~/Library/PreferencesPanes/JavaControlPanel.prefpane

sudo rm -rf ~/Library/Application\ Support/Oracle/Java

```

* 查找当前已安装的Java版本

```shell
//输入：
ls ~/Library/Java/JavaVirtualMachines

//输出：
jdk1.8.0_211.jdk jdk-11.0.1.jdk
```

* 选择想要卸载的版本，进行卸载

```
sudo rm -rf /Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk
```

* 再次查看当前已安装的Java版本

```shell
//输入：
ls /Library/Java/JavaVirtualMachines/

//输出：
jdk1.8.0_211.jdk
```



## 卸载idea

* 应用程序删除

* 删除其余文件

```shell
rm -rf ~/Library/Preferences/IntelliJIdea
rm -rf ~/Library/Caches/IntelliJIdea
rm -rf ~/Library/Application Support/IntelliJIdea
rm -rf ~/Library/ApplicationSupport/IntelliJIdea
rm -rf ~/Library/Logs/IntelliJIdea
```

* 可以使用 `/usr/libexec/java_home -V` 查看jdk的目录

## 直接软链安装软件

 因为系统默认会从 `/usr/local/bin` 下寻找资源，所以只要把软件的入口软链到此处即可。例如安装maven

```shell
sudo ln -fs /Users/panjianghong/programs/apache-maven-3.6.0/bin/mvn /usr/local/bin/mvn
```



## 关闭SIP机制（没有root权限）

* 关机后开机时一直按着电源键，以便进入保护模式
* 右上角 -> 实用工具 -> 终端 
* 输入 `csrutil disable`
* 成功执行之后 `reboot`重启电脑
* 启动之后 `关于本机`-> `系统报告` -> `软件` -> `系统完整性保护`这一项数据会改为已关闭



## 安装brew

* 安装

```shell
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
```

* 卸载

```shell
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/HomebrewUninstall.sh)"
```



## 异常问题

### No compiler is provided in this environment. Perhaps you are running on a JRE rather than a JDK

在cmd中可以正常使用java -v等命令，但是在maven中打包出现异常，执行`mvn -v`获得

```
Apache Maven 3.6.0 (97c98ec64a1fdfee7767ce5ffb20918da4f719f3; 2018-10-25T02:41:47+08:00)
Maven home: /Users/panjianghong/programs/apache-maven-3.6.0
Java version: 1.8.0_341, vendor: Oracle Corporation, runtime: /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
Default locale: zh_CN, platform encoding: UTF-8
OS name: "mac os x", version: "12.6", arch: "x86_64", family: "mac"
```

明显是maven中的java环境配置异常了，仔细回想，是直接使用了ln -s把maven的执行文件软链到`/usr/local/bin`中了，现在重新在 `$USER_HOME/.bash_profile`中配置好`MAVEN_HOME`即可

```
export MAVEN_HOME=/Users/panjianghong/programs/apache-maven-3.6.0
export PATH=$PATH:$MAVEN_HOME/bin
```

修改完记得执行 `source .bash_profile` 刷新文件内容

jdk的安装目录可以使用 `/usr/libexec/java_home -V` 查看（mac）



### 重启cmd后.bash_profile配置文件失效

`/.bash_profile`生效的前提是我们需要使用`bash`作为终端，随着系统的升级MAC会将默认终端切换为`zsh`，如果我们稍不注意按照提示进行了修改，那么就会导致`～/.bash_profile`无效

方法一

将终端切换成 bash

```shell
chsh -s /bin/bash
```

方法二

继续使用 zsh，但是在 `.zshrc` 文件中添加对 `.basg_profile` 的引用

若是没有 `.zshrc` 文件，可以自己创建

```
# 进入根目录
cd ~  
# 创建zprofile文件
touch .zprofile
# 编辑
vim .zprofile
# 使文件生效
source .zprofile
```

```
if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
fi
```



### MacOS中ssh连接自动断开问题解决

在MacOS平台，使用ssh登录linux[服务器](https://cloud.tencent.com/product/cvm?from=10680)后，在后台放置一段时间，就会自动断开，解决的方法如下 ：

```shell
vim /etc/ssh/ssh_config
```

复制

添加下面两条设置:

```js
ServerAliveCountMax 3
ServerAliveInterval 5
```

复制

- `ServerAliveCountMax 3` 表示服务器发出请求后，客户端没有响应的次数达到一定值, 就自动断开。正常情况下, 客户端不会不响应。
- `ServerAliveInterval 5` 指定了服务器端向客户端请求消息的时间间隔，默认是0，不发送。而`ServerAliveInterval 5`表示每5秒向服务器发送一次，这样就保持长连接了。

`/etc/ssh/` 目录下除了`ssh_config`之外，还有一个`sshd_config`，二者的区别在于，前者是针对**客户端**的配置文件，后者是针对**服务端**的文件

### 

### 更新系统后，软件栏会有一个带问号的系统图标

```
按住option再点击 X 就可以删除

如果是空白图标，可在终端执行以下命令

defaultswritecom.apple.dockResetLaunchPad-boolTRUE
killallDock
```

## zsh添加插件

```shell
# 创建插件存放文件夹并进入
mkdir -p ~/.zsh/custom/plugin && cd ~/.zsh/custom/plugin

# 下载插件
git clone git@github.com:zsh-users/zsh-autosuggestions.git
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git

# 添加环境变量
vim ～/.zshrc

  source ~/.zsh/custom/plugin/zsh-autosuggestions
  source ~/.zsh/custom/plugin/zsh-syntax-highlighting

# 保存后执行

source ～/.zshrc

```

## Mac m1安装golang

* 下载地址 https://www.gomirrors.org
* 下载 `go1.19.3.darwin-arm64.pkg` 的 `arm64`版本
* 安装好之后查看go的版本和环境变量

```
# 查看版本
go version

# 查看环境变量
go env
```



## Github 国内加速访问

### Mac 修改方法:

#### 修改 /etc/hosts:

- 特别提醒:
  - 网上找到的 host, 不要轻易添加.
  - 先通过 ping 查看一下. 是否 ping 的通, 且速度是否够快.
  - 添加了 不同的 host IP, 反而会使访问速度更慢.
  - 上述 IP, 是在联通网络下, 访问非常快. 使用前, 请自行测试.
- 添加如下内容:

```
###################################
#       Github:
###################################
103.245.222.249 github.global.ssl.fastly.net

103.245.222.133 assets-cdn.github.com
23.235.47.133   assets-cdn.github.com

185.31.19.133   avatars1.githubusercontent.com
```

#### 修改 /etc/resolv.conf

- 添加如下内容:

```
# add for github:
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 114.114.114.114
```

#### 刷新 NDS, 使之生效:

```
sudo dscacheutil -flushcache
```

### Linux 修改方法:

- 同样修改:
  - /etc/hosts
  - /etc/resolv.conf
- 刷新启动命令:

```
sudo /etc/init.d/networking restart
```

### 参考:

- [GitHub加速访问](http://chenxuhua.com/technology/githubjia-su-fang-wen)
- [Github访问很慢的解决方法](http://www.jianshu.com/p/a578963f10f0)
- [GtiHub访问慢解决办法](https://segmentfault.com/a/1190000004171536)
