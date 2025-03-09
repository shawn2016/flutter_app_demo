import 'package:get/get.dart';
import 'test_user_controller.dart';

class TestUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestUserController>(() => TestUserController());
  }
}
