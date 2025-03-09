import 'package:get/get.dart';
import 'login_service.dart';

class LoginController extends GetxController {
  var testData = ''.obs;

  void testFunction(int testData) {
    this.testData.value = LoginService.getTestData();
  }
}

