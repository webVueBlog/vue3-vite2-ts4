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