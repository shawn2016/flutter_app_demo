import 'package:get/get.dart';
import 'test_user_service.dart';

class TestUserController extends GetxController {
  var testData = ''.obs;

  void testFunction(int testData) {
    this.testData.value = TestUserService.getTestData();
  }
}

