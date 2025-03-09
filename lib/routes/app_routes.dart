import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../pages/launch/launch_page.dart';
import '../pages/launch/launch_binding.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_binding.dart';
import '../pages/test_user/test_user_page.dart';
import '../pages/test_user/test_user_binding.dart';

import '../pages/home/home_binding.dart';

class AppRoutes {
  static const String home = '/home';
  static const String launch = '/launch';
  static const String login = '/login';
  static const String testUser = '/testUser';

  // 不需要登录的页面
  static const noAuthRoutes = [];

  static final routes = [
    GetPage(
      name: AppRoutes.launch,
      page: () => LaunchPage(),
      binding: LaunchBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.testUser,
      page: () => TestUserPage(),
      binding: TestUserBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  // @override
  // RouteSettings? redirect(String? route) {
  //   // 不需要登录的页面，正常跳转
  //   if (AppRoutes.noAuthRoutes.contains(route)) return null;

  //   bool isLoggedIn = AuthService.isLoggedIn();

  //   // 如果未登录，直接取消导航，返回 login 页面
  //   if (!isLoggedIn && route != AppRoutes.login) {
  //     return RouteSettings(name: AppRoutes.login);
  //   }

  //   // 正常跳转
  //   return null;
  // }
}
