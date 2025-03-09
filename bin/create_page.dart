import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty || !arguments.first.startsWith('--name=')) {
    print('Usage: dart bin/create_page.dart --name=xxx [-y]');
    return;
  }

  final pageName = arguments.first.split('=')[1];
  final className = _toPascalCase(pageName);
  final fileName = _toSnakeCase(pageName);
  final routeName = _toCamelCase(pageName);
  final bool forceOverwrite = arguments.contains('-y');

  final basePath = 'lib';
  final pagePath = '$basePath/pages/$fileName/${fileName}_page.dart';
  final controllerPath =
      '$basePath/pages/$fileName/${fileName}_controller.dart';
  final servicePath = '$basePath/pages/$fileName/${fileName}_service.dart';
  final bindingPath = '$basePath/pages/$fileName/${fileName}_binding.dart';
  final routesPath = '$basePath/routes/app_routes.dart';

  // 创建目录
  Directory('$basePath/pages/$fileName').createSync(recursive: true);

  // 创建文件
  _createFileWithPrompt(
    pagePath,
    _pageTemplate(className, fileName),
    forceOverwrite,
  );
  _createFileWithPrompt(
    controllerPath,
    _controllerTemplate(className, fileName),
    forceOverwrite,
  );
  _createFileWithPrompt(
    bindingPath,
    _bindingTemplate(className, fileName),
    forceOverwrite,
  );
  _createFileWithPrompt(
    servicePath,
    _serviceTemplate(className),
    forceOverwrite,
  );

  // 修改路由文件
  _updateRoutesFile(routesPath, className, fileName, routeName);

  Log.i('Page "$className" created successfully!');
}

void _createFileWithPrompt(
  String filePath,
  String content,
  bool forceOverwrite,
) {
  final file = File(filePath);
  if (file.existsSync() && !forceOverwrite) {
    stdout.write('$filePath already exists. Overwrite? (Y/n): ');
    final response = stdin.readLineSync()?.toLowerCase() ?? 'y';
    if (response != 'y' && response != '') {
      print('Skipping $filePath');
      return;
    }
  }
  file.writeAsStringSync(content);
  print('Created: $filePath');
}

// 转换命名
String _toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join();
}

// 转换命名
String _toSnakeCase(String input) {
  return input
      .replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (match) => '${match[1]}_${match[2]}',
      )
      .toLowerCase();
}

// 转换命名
String _toCamelCase(String input) {
  List<String> words = input.split('_');
  return words.first +
      words
          .skip(1)
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join();
}

String _pageTemplate(String className, String fileName) {
  return """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '${fileName}_controller.dart';

class ${className}Page extends GetView<${className}Controller> {
  const ${className}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$className Page')),
      body: Center(child: Text('Welcome to $className Page')),
    );
  }
}
""";
}

String _bindingTemplate(String className, String fileName) {
  return """
import 'package:get/get.dart';
import '${fileName}_controller.dart';

class ${className}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${className}Controller>(() => ${className}Controller());
  }
}
""";
}

String _controllerTemplate(String className, String fileName) {
  return """
import 'package:get/get.dart';
import '${fileName}_service.dart';

class ${className}Controller extends GetxController {
  var testData = ''.obs;

  void testFunction(int testData) {
    this.testData.value = ${className}Service.getTestData();
  }
}

""";
}

String _serviceTemplate(String className) {
  return """
class ${className}Service {
  // 示例静态函数
  static String getTestData() {
    return "Data from ${className}Service";
  }
}
""";
}

void _updateRoutesFile(
  String filePath,
  String className,
  String fileName,
  String routeName,
) {
  final file = File(filePath);
  if (!file.existsSync()) {
    Log.e('app_routes.dart not found');
    return;
  }

  String content = file.readAsStringSync();

  final pageImportStatement =
      "import '../pages/$fileName/${fileName}_page.dart';";
  final controllerImportStatement =
      "import '../pages/$fileName/${fileName}_controller.dart';";

  final bindingImportStatement =
      "import '../pages/$fileName/${fileName}_binding.dart';";

  if (!content.contains(pageImportStatement)) {
    content = content.replaceFirst(
      "import 'package:get/get.dart';",
      "import 'package:get/get.dart';\n$pageImportStatement",
    );
  }

  if (!content.contains(bindingImportStatement)) {
    content = content.replaceFirst(
      pageImportStatement,
      "$pageImportStatement\n$bindingImportStatement",
    );
  }

  final routeConstant = "static const String $routeName = '/$routeName';";
  if (!content.contains(routeConstant)) {
    content = content.replaceFirst(
      'class AppRoutes {',
      'class AppRoutes {\n  $routeConstant',
    );
  }

  final routeEntry = """GetPage(
      name: AppRoutes.$routeName, 
      page: () => ${className}Page(), 
      binding: ${className}Binding(), 
      middlewares: [AuthMiddleware()],
    ),""";
  if (!content.contains("name: AppRoutes.$routeName,")) {
    content = content.replaceFirst(
      'static final routes = [',
      'static final routes = [\n    $routeEntry',
    );
  }

  file.writeAsStringSync(content);
}

class Log {
  static void e(String message) {
    print('\x1B[31m [ERROR] $message \x1B[0m');
  }

  static void i(String message) {
    print('\x1B[32m [INFO] $message \x1B[0m');
  }

  static void w(String message) {
    print('\x1B[33m [WARN] $message \x1B[0m');
  }

  static void d(String message) {
    print('\x1B[34m [DEBUG] $message \x1B[0m');
  }
}
