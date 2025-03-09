# flutter_app_demo

> flutter 基础框架

## 特性

- [x] 状态管理：GetX
- [x] 路由管理：GetX
- [x] 路由拦截：middlewares
- [x] 路由 Controller 绑定：GetPage -> binding
- [x] 全局 Controller 绑定: app.dart -> initialBinding
- [x] 网络请求封装：commons/ajax.dart -> dio
- [x] 主题切换：GetX
- [x] 枚举：封装 enums
- [x] 区分环境配置： config
- [x] 本地存储、区分 local 和 session 级别：commons/storage.dart
- [x] iconfont 图标：脚本基于 iconfont.json 生成
- [x] 国际化：GetX
  - [ ] 可以考虑支持 RTL
  - [ ] 预留动态加载语言包的接口
- [x] 全局错误捕获上报服务器
- [x] MVVM 模式：models/pages/controllers/services
- [x] 日志管理：commons/logger.dart
- [x] 启动屏：纯 Flutter 组件方式实现，如果是 android 或 ios 可以考虑使用 flutter_native_splash +
      Flutter 组件方式，避免白屏 + 处理业务逻辑
- [x] 屏幕适配（缩放）：flutter_screenutil
- [x] 代码生成 build_runner + 自定义脚本
- [x] 代码规范：git_hooks
- [ ] app 版本检测，下载新的版本
- [ ] 如何做热更新或者类似热更新
- [ ] 依赖注入：injectable
- [ ] 权限管理：permission_handler 处理相机、存储、GPS 等权限 app_settings 让用户跳转到系统设置页
- [ ] 多平台登录
  - [ ] 集成社交登录（如 Google、Facebook、Apple）或 Firebase Auth，统一管理用户身份。
- [ ] 安全存储：使用 flutter_secure_storage 存储敏感信息，提升数据安全性。
- [ ] 离线支持与数据同步
  - [ ] 离线缓存：为网络请求添加缓存机制（例如使用 Dio 的拦截器或结合 Hive、SQFlite）；
  - [ ] 数据同步：考虑支持断网情况下的数据存储与后台同步。
- [ ] 推送通知：集成 firebase_messaging 或其他通知服务，实现跨平台推送；
- [ ] 实时消息：支持 WebSocket 或 GraphQL 的订阅机制，用于实时数据更新。
- [ ] Crash Reporting：集成 Sentry、Firebase Crashlytics 等服务，不仅上报错误，还能分析崩溃原因；
- [ ] 性能监控：添加性能分析工具，监控启动时间、内存占用、帧率等，帮助优化体验。
- [ ] 单元测试与集成测试：为核心模块编写测试用例，确保业务逻辑的正确性；
- [ ] Mock 与依赖注入：利用现有的依赖注入方案（如 injectable）为测试提供 mock 实现，方便进行单元测试与 UI 测试。

## 代码生成

通过代码生成，简化开发流程，提高开发效率。

### 基础代码生成

- models 生成： 基于 json_serializable 做`*.g.dart`相关文件生成
- iconfont：基于 builder/iconfont_builder.dart 生成 `gen/icon_font.gen.dart`
- assets: 基于 flutter_gen 做资源文件生成 `gen/assets.gen.dart`

注意：项目拉取下来之后，首先通过如下命令生成代码。

```bash
# 清除缓存
dart run build_runner clean

# 生成代码 强制覆盖已存在的生成文件
dart run build_runner build --delete-conflicting-outputs
```

### 生成页面

基于`bin/create_page.dart` 生成 pages/controllers/services 修改路由文件`routes/app_routes.dart`

#### 参数说明：

1. --name=xxx 指定名称
2. -y 强制覆盖已存在文件

#### 最终会生成：

1. 创建：pages/test_user/test_user_page.dart;
2. 创建：controllers/test_user_controller.dart;
3. 创建：services/test_user_service.dart;
4. 修改：routes/app_routes.dart

```bash
# 例如生成一个test_user页面

dart bin/create_page.dart --name=test_user -y
```

## 打开模拟器

```bash
flutter emulators
flutter emulators --launch <模拟器名称>
```

## 区分环境配置

项目中，区分环境配置主要是通过`RUN_ENV`变量来实现的，在`lib/config/config.dart`中根据`RUN_ENV`变量来配置不同的环境。

```bash
# 开发环境
flutter run --dart-define=RUN_ENV=dev

# 生产环境
flutter run --dart-define=RUN_ENV=production

# 测试环境
flutter run --dart-define=RUN_ENV=test

# 打包Android
flutter build apk --release --shrink --dart-define=RUN_ENV=production

# 打包iOS
flutter build ios --dart-define=RUN_ENV=production
```

## 代码规范

项目中，代码规范主要是通过`analysis_options.yaml`文件来实现的。

git_hooks 结合，提交时检测：

```bash
# 安装 git_hooks
dart bin/git_hooks_init.dart

# 卸载 报错忽略，库有问题，其实已经卸载了
dart bin/git_hooks_un_install.dart
```

## 测试

Flutter 约定测试文件放在`/test`目录中，测试文件以`_test.dart`结尾，例如`test/widget_test.dart`。

运行测试：

```bash
flutter test
```

## 参考文档

- [Flutter 官方文档](https://docs.flutter.dev)
- [Flutter 官方示例](https://github.com/flutter/samples)
- [Flutter 官方插件](https://pub.dev/flutter)
- [Flutter 官方插件](https://pub.dev/flutter)
- [Flutter 学习 Codelabs](https://codelabs.developers.google.cn/?hl=zh-cn&text=flutter)
- [GetX 路由、状态、国际化等](https://github.com/jonataslaw/getx)
- [GetX 路由管理](https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/route_management.md)
- [Flutter 项目名称修改](https://github.com/onatcipli/rename)
