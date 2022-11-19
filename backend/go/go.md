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

* 默认安装在 `/usr/local/go`下

* 添加 `go module`的依赖管理

```
#GO module
export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/ 
```







## 代理问题

配置国内的代理

* 阿里云

```go
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
```

* 七牛云

```go
go env -w GOPROXY=https://goproxy.cn,off
```

!>  “off” ：禁止 Go 在后续操作中使用任何 Go module proxy。

!> “direct” 为特殊指示符，用于指示 Go 回源到模块版本的源地址去抓取(比如 GitHub 等)，当值列表中上一个 Go module proxy 返回 404 或 410 错误时，Go 自动尝试列表中的下一个。

Go 高版本设置了默认的GOSUMDB=[sum.golang.org](https://links.jianshu.com/go?to=http%3A%2F%2Fsum.golang.org)，是用来验证包的有效性。这个网址由于墙的原因可能无法访问，所以可以使用下面命令来关闭

```go
go env -w GOSUMDB=off
```

`go mod download`会默认走我们配置的 `GOPROXY`，私有仓库可以设置不走代理

```go
go env -w GONOPROXY="github.com" 
或
go env -w  GOPRIVATE="github.com"
```





## 研发问题

### package command-line-arguments is not a main package

因为main.go的运行需要特殊格式

```go
package main

import "fmt"

func main() {
	fmt.Println("afad")
}
```

若` package`不是` main` 则会报这个错误

### tealeg/xlsx添加单元格背景颜色失败

需要添加 `PatternType: xlsx.Solid_Cell_Fill`配置，并且显示颜色为 ` FgColor: fgColor`

```go
xlsx.Fill{PatternType: xlsx.Solid_Cell_Fill, FgColor: fgColor}
```

