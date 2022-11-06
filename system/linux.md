## 通用指令

```shell
uname -a # 查看内核/操作系统/CPU信息 
head -n 1 /etc/issue # 查看操作系统版本 
cat /proc/cpuinfo # 查看CPU信息 
hostname # 查看计算机名 
lspci -tv # 列出所有PCI设备 
lsusb -tv # 列出所有USB设备 
lsmod # 列出加载的内核模块 
env # 查看环境变量资源 
free -m # 查看内存使用量和交换区使用量 
df -h # 查看各分区使用情况 
du -sh <目录名> # 查看指定目录的大小 
grep MemTotal /proc/meminfo # 查看内存总量 
grep MemFree /proc/meminfo # 查看空闲内存量 
uptime # 查看系统运行时间、用户数、负载 
cat /proc/loadavg # 查看系统负载磁盘和分区 
mount | column -t # 查看挂接的分区状态 
fdisk -l # 查看所有分区 
swapon -s # 查看所有交换分区 
hdparm -i /dev/hda # 查看磁盘参数(仅适用于IDE设备) 
dmesg | grep IDE # 查看启动时IDE设备检测状况网络 
ifconfig # 查看所有网络接口的属性 
iptables -L # 查看防火墙设置 
route -n # 查看路由表 
netstat -lntp # 查看所有监听端口 
netstat -antp # 查看所有已经建立的连接 
netstat -s # 查看网络统计信息进程 
ps -ef # 查看所有进程 
top # 实时显示进程状态用户 
w # 查看活动用户 
id <用户名> # 查看指定用户信息 
last # 查看用户登录日志 
cut -d: -f1 /etc/passwd # 查看系统所有用户 
cut -d: -f1 /etc/group # 查看系统所有组 
crontab -l # 查看当前用户的计划任务服务 
chkconfig –list # 列出所有系统服务 
chkconfig –list | grep on # 列出所有启动的系统服务程序 
rpm -qa # 查看所有安装的软件包
lsof -i:80 # 查看80端口的占用情况
```



## 通用脚本

### 过滤注释配置

```shell
cat redis.conf | grep -v "#" | grep -v "^$"
```



### zip剔除文件打包

```shell
zip -r 2022-11-03-extra.zip 2022-11-03-extra -x ".DS_Store" -x "__MACOSX"
```



## 查询服务器当前时间

```shell
echo `date +%Y%m%d`
```

* 参数

  ```
  % H 小时(00..23)
  % I 小时(01..12)
  % k 小时(0..23)
  % l 小时(1..12)
  % M 分(00..59)
  % p 显示出AM或PM
  % r 时间(hh：mm：ss AM或PM)，12小时
  % s 从1970年1月1日00：00：00到目前经历的秒数
  % S 秒(00..59)
  % T 时间(24小时制)(hh:mm:ss)
  % X 显示时间的格式(％H:％M:％S)
  % Z 时区 日期域
  % a 星期几的简称( Sun..Sat)
  % A 星期几的全称( Sunday..Saturday)
  % b 月的简称(Jan..Dec)
  % B 月的全称(January..December)
  % c 日期和时间( Mon Nov 8 14：12：46 CST 1999)
  % d 一个月的第几天(01..31)
  % D 日期(mm／dd／yy)
  % h 和%b选项相同
  % j 一年的第几天(001..366)
  % m 月(01..12)
  % w 一个星期的第几天(0代表星期天)
  % W 一年的第几个星期(00..53，星期一为第一天)
  % x 显示日期的格式(mm/dd/yy)
  % y 年的最后两个数字( 1999则是99)
  % Y 年(例如：1970，1996等)
  %F 输出日期为2017-04-03 这种格式的日期
  ```

  

## linux rz/sz 文件卡死快速退出方法

- 按住Ctrl键, 再按五次x键 (强行终断传输)



## ssh “permissions are too open” error

```
Permissions 0644 for '/Users/panjianghong/command-line/tengxunyun.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "/Users/panjianghong/command-line/tengxunyun.pem": bad permissions
root@49.235.198.77: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
```

!> 密钥权限过大错误，把文件的权限降低就行，一般授权600 即可; chmod 400 filename



## 退出ssh远程链接

| 序号  | 方法         | 特点                  |
| ----- | ------------ | --------------------- |
| 方法1 | 直接关闭终端 | 简单粗暴              |
| 方法2 | 输入logout   | 比较正式的退出方式    |
| 方法3 | 输入exit     | 等同于方法2           |
| 方法4 | Ctrl + D     | 等同于方法2，方便快捷 |





## 所有镜像的操作

```shell
# 启动所有镜像
docker start $(docker ps -a -q)
 
# stop停止所有容器
docker stop $(docker ps -a -q)
 
# remove删除所有容器
docker rm $(docker ps -a -q) 

# 删除所有退出的镜像
sudo docker rm `docker ps -a|grep Exited|awk '{print $1}'`
```



## Error: No such container

```shell
删除镜像一直报错，直接关闭docker后删除镜像文件

service docker stop

rm -rf /var/lib/docker
```



## k8s卸载

```shell
步骤如下：
kubeadm reset -f
rm -rf ~/.kube/
rm -rf /etc/kubernetes/
rm -rf /etc/systemd/system/kubelet.service.d
rm -rf /etc/systemd/system/kubelet.service
rm -rf /usr/bin/kube*
rm -rf /etc/cni
rm -rf /opt/cni
rm -rf /var/lib/etcd
rm -rf /var/etcd
```
