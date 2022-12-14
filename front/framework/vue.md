## Vue问题及修复

### chorm安装vue-devtools不能调试本地文件

```text
在 扩展程序 -> vue-devtools -> 详情 -> 允许访问文件网址 -> 选择开启
```

### chorm安装vue-devtools显示`Devtools inspection is not available because it's in production mode or explicitly disabled by the author.`

```text
检查自己是否使用压缩后的js，vue.min.js，使用压缩后的js文件，会失去错误提示和警告。也可能会导致上面的问题。
```

### vue 2 snippets提示不生效

```text
在vscode右下角有一个 html 标签，点击这个数据修改成vue或者vue-html
```

### html标签提示不是很友好

```text
在键入数据的时候，先不要输入 < 符号，然后提示会友好很多
```


### vue方法同时传递标签和参数

```html
<button @click="tm($event,123)">ddddd</button>
```

### 处理 keyup.enter 和 blur 事件冲突的问题

```html
有些场景想要在 input 里输入文字，当触发回车或者失去焦点时保存数据
但是当按下回车时往往又会同时触发 blur 事件
所以就会触发两次保存操作，对此有个小技巧，就是让回车触发失去焦点事件
<input 
	v-model="newValue"
	type="text"
	@blur="saveValue"
	@keyup.enter="$event.target.blur">
```

## js库

*  [Lodash](https://github.com/lodash/lodash) & [Underscore](https://github.com/jashkenas/underscore)

```text
也许大多数童鞋都已经知道它们。Underscore 提供了日常使用的基础函数。
Lodash，作为 NPM 最多下载量和被依赖最多的包，旨在为数组，字符串，对象和参数对象提供更一致的跨环境迭代支持。
它已经是 Underscore 的超集。Underscore 和 Lodash 由同一组核心开发者维护。
你日常开发中绝对少不了要用到它
```


* [Ramda](https://github.com/ramda/ramda)

```text
拥有超过 12K 的 stars，Ramda 库可以用来在 JavaScript 中函数式编程，专门为函数式编程风格而设计，更容易创建函数式 pipeline、且从不改变用户已有数据
```


* [Math.js](https://github.com/josdejong/mathjs)

```text
拥有超过 6K 的 stars，Math.js 是一个 Node.js 和 JavaScript 上的 math 扩展库，并且和内置的 Math 库兼容。
该库中包含一个灵活的表达式分析器，并且有非常多的内置函数可以使用。你甚至可以自行做扩展。
```


* [Moment](https://github.com/moment/moment/) && [date-fns](https://github.com/date-fns/date-fns)

```text
拥有超过 40K 的 stars，moment.js 是一个 JavaScript 的时间处理库，可以用来分析、验证、处理和格式化时间。Moment 被设计可以用于浏览器和 Node.js 环境下。对于 V2.10.0，代码完全用 ECMAScript 6 实现。

Date-fns 也是一个非常流行(超过 11K 的 stars)的时间处理库，提供超过 130 多个函数，很多人把它当做 moment.js的替代品。Date-fns 完全用纯函数实现，保证不可修改性。它可以很好的和 webpack，Browserify、或 Rollup 配合使用，并支持 tree-shaking
```

* [Sugar](https://github.com/andrewplummer/Sugar)

```text
拥有超过 3.5K 个 stars，Sugar 是一个可以用来处理原生对象的库。拥有自定义的构建和模块化的 npm 包，使得你可以只需要加载你需要的包。用户也可以自定义方法或则使用插件处理特殊情况。
```

* [Lazy](https://github.com/dtao/lazy.js)

```text
拥有 5K 个 stars，lazy.js 是一个函数式的 JavaScript 库。该库的底层的实现都是懒执行的，也就是说尽量不做运算，除非真的需要。这个库不依赖第三方库。
```

* [CollectJS](https://github.com/ecrmnn/collect.js/)

```text
拥有超过 3.5K 个 stars，collect.js 是一个非常有前景并且不依赖于任何第三方库。它提供了针对数组和对象的包装，使用非常方便。
```

* [ChanceJS](https://github.com/chancejs/chancejs)

```text
Chance 是一个用来随机生成字符串、数字等的函数，他可以减少一些伪随机性，在你需要写自动化测试或则其它你需要生成随机数据的地方很有用。虽然只有 3K 个 stars，但是这个库真的非常方便。
```

* [ChartJS](https://github.com/chartjs/Chart.js)

```text
拥有超过 40K 个 stars，chart.js 是一个少即是多的的经典例子。它只提供了 8 种可视化的类型，每一种都有动画并且可以自定义。Chart.js 让你可以使用<canvas>标签来作图，并且在不同的浏览器上高效渲染。
```

* [Polished](https://github.com/styled-components/polished)

```text
拥有超过 3.5K 个 stars，由styled-components团队开发，Polished 是一个用于写 css 样式的工具集，提供 sass 风格的帮助函数和 mixins。该库和 styled-components，Aphrodite，Radium 兼容。
```

* [Voca](https://github.com/panzerdp/voca)

```text
一个用于处理字符串的 JavaScript 库，包含了很多的帮助函数，比如：change case, trim, pad, slugify, latinise, sprintf‘y, truncate, escape 等等。
```

* [Licia](https://github.com/liriliri/licia)

```text
Licia 是一套在开发中实践积累起来的实用 JavaScript 工具库。该库目前拥有超过 180 个模块，包括 Dom 操作，cookie 设置，类创建，模板函数，日期格式化等实用模块，同时配套有打包工具 Eustia 进行定制化，使 JS 脚本加载量缩减在 10KB 以下，极大优化移动端页面的加载速度
```





