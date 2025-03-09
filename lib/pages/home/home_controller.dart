import 'package:get/get.dart';
import 'home_service.dart';

class HomeController extends GetxController {
  var testData = ''.obs;

  void testFunction(int testData) {
    this.testData.value = HomeService.getTestData();
  }
}

