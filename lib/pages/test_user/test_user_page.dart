import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'test_user_controller.dart';

class TestUserPage extends GetView<TestUserController> {
  const TestUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TestUser Page')),
      body: Center(child: Text('Welcome to TestUser Page')),
    );
  }
}
