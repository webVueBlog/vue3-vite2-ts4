# Vue 3 + Typescript + Vite

vue3-vite2-ts4

```js
npm init @vitejs/app
vue
vue-ts
npm install
npm run dev
```

<img src="./demo/20220228094015.png" width="100%"/>

目录结构如下
​
```js
├── public              静态资源
├── src
│   ├── assets           资源目录（图片、less、css等）
│   ├── components       项目组件
│   ├── App.vue          主应用
│   ├── env.d.ts         全局声明
│   └── main.ts          主入口
├── .gitignore           git忽略配置
├── index.html           模板文件
├── package.json        依赖包/运行脚本配置文件
├── README.md
├── tsconfig.json        ts配置文件
├── tsconfig.node.json   ts配置文件
└── vite.config.ts       vite配置
```

每个目录的作用后文都会提及

```js
├── src
│   ├── router           路由配置
│   ├── stores           状态管理
│   ├── typings          ts公共类型
│   ├── utils            工具类函数封装
│   └── views            页面视图
```

指定解析路径使用的 path module需要先安装`@type/node`

```js
npm install @types/node --save-dev
```

打包功能

```js
build: {
      outDir: 'dist',   // 指定打包路径，默认为项目根目录下的 dist 目录
      terserOptions: {
          compress: {
              keep_infinity: true,  // 防止 Infinity 被压缩成 1/0，这可能会导致 Chrome 上的性能问题
              drop_console: true,   // 生产环境去除 console
              drop_debugger: true   // 生产环境去除 debugger
          },
      },
      chunkSizeWarningLimit: 1500   // chunk 大小警告的限制（以 kbs 为单位）
}
```

## 接入代码规范

ESlint 被称作下一代的 JS Linter 工具，能够将 JS 代码解析成 AST 抽象语法树，然后检测 AST 是否符合既定的规则。

```js
yarn add eslint @typescript-eslint/parser @typescript/eslint-plugin eslint-plugin-vue
```

TypeScirpt 官方决定全面采用 ESLint 作为代码检查的工具，并创建了一个新项目 typescript-eslint，提供了 TypeScript 文件的解析器 @typescript-eslint/parser 和相关的配置选项 @typescript-eslint/eslint-plugin 等

## 使用 scss 来增强 css 的语法能力

```js
yarn add sass
yarn add stylelint
yarn add stylelint-scss
```

## 接入naive ui库

Naive UI 是尤大推荐的 vue3 UI 库(https://www.naiveui.com/zh-CN/os-theme)

## 接入 vue-router

```js
npm install vue-router --save
```

```js
import {
    createRouter, createWebHashHistory, RouteRecordRaw,
} from 'vue-router'
​
const routes: Array<RouteRecordRaw> = [
    { path: '/', name: 'Home', component: () => import('views/home/index.vue')}
]
​
const router = createRouter({
    history: createWebHashHistory(),    // history 模式则使用 createWebHistory()
    routes,
})
​
export default router
```

```js
import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index'
​
const app = createApp(App as any)
app.use(router)
```

## 接入状态管理工具 pinia

pinia 是一个轻量级的状态管理库

```js
npm install pinia --save
```

引入

在 main.ts中引入

```js
import { createPinia } from 'pinia'
​
app.use(createPinia())
```

在src/stores下新建一个counters.ts文件

```js
import { defineStore } from 'pinia'
​
export const useCounterStore = defineStore('counter', {
    state: () => {
        return {
            count: 0
        }
    },
    getters: {
        count() {
            return this.count
        }
    },
    actions: {
        increment() {
            this.count++
        }
    }
})
```

```js
import { defineStore } from 'pinia'
​
export const useCounterStore = defineStore('counter', () => {
    const count = ref(0)
    function increment() {
      count.value++
    }
​
    return { count, increment }
})
```

## 接入图表库 echarts5

安装&引入

```js
npm install echarts --save
```

在src/utils/下新建echarts.ts用来引入我们需要使用的组件

```js
import * as echarts from 'echarts/core'
import {
    BarChart,
    // 系列类型的定义后缀都为 SeriesOption
    BarSeriesOption,
    // LineChart,
    LineSeriesOption
} from 'echarts/charts'
import {
    TitleComponent,
    // 组件类型的定义后缀都为 ComponentOption
    TitleComponentOption,
    TooltipComponent,
    TooltipComponentOption,
    GridComponent,
    GridComponentOption,
    // 数据集组件
    DatasetComponent,
    DatasetComponentOption,
    // 内置数据转换器组件 (filter, sort)
    TransformComponent,
    LegendComponent
} from 'echarts/components'
import { LabelLayout, UniversalTransition } from 'echarts/features'
import { CanvasRenderer } from 'echarts/renderers'
​
// 通过 ComposeOption 来组合出一个只有必须组件和图表的 Option 类型
export type ECOption = echarts.ComposeOption<
    | BarSeriesOption
    | LineSeriesOption
    | TitleComponentOption
    | TooltipComponentOption
    | GridComponentOption
    | DatasetComponentOption
>
​
// 注册必须的组件
echarts.use([
    TitleComponent,
    TooltipComponent,
    GridComponent,
    DatasetComponent,
    TransformComponent,
    BarChart,
    LabelLayout,
    UniversalTransition,
    CanvasRenderer,
    LegendComponent
])
​
// eslint-disable-next-line no-unused-vars
const option: ECOption = {
    // ...
}
​
export const $echarts = echarts
```

就可以在页面中使用了：

```js
<script lang="ts" setup>
    import { onMounted } from 'vue'
    import { $echarts, ECOption } from '@/utils/echarts'
​
    onMounted(() => {
        // 测试echarts的引入
        const ele = document.getElementById('echarts') as HTMLCanvasElement
        const myChart = $echarts.init(ele)
        const option: ECOption = {
            title: {
                text: 'ECharts 入门示例'
            },
            tooltip: {},
            legend: {
                data: ['销量']
            },
            xAxis: {
                data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
            },
            yAxis: {},
            series: [
                {
                    name: '销量',
                    type: 'bar',
                    data: [5, 20, 36, 10, 10, 20]
                }
            ]
        }     
</script>
```

## 配置统一 axios 处理

安装&引入

```js
npm install axios --save
```
