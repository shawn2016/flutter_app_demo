import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class LaunchController extends GetxController {
  var opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    opacity.value = 1.0;

    // 3秒后跳转到主页面 路由有统一拦截，如果没有登录，会自动跳转到登录页面
    await Future.delayed(Duration(seconds: 0));
    Get.offAllNamed(AppRoutes.home);
  }
}
