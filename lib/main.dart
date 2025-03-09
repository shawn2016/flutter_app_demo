import 'package:flutter/material.dart';
import 'package:flutter_app_demo/routes/app_routes.dart';
import 'package:get/get.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return GetMaterialApp(
      title: "Study State",
      theme: ThemeData(useMaterial3: true),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.launch,
    );
    // });
  }
}
