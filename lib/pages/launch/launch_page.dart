import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../gen/assets.gen.dart';
import 'launch_controller.dart';

class LaunchPage extends GetView<LaunchController> {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Obx(
          () => Opacity(
            opacity: controller.opacity.value,
            child: Center(
              child: Assets.images.logo.image(width: 150, height: 150),
            ),
          ),
        ),
      ),
      // Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     Container(
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           colors: [Colors.blue, Colors.purple],
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //         ),
      //       ),
      //     ),
      //     Center(
      //       child: Obx(
      //         () => Opacity(
      //           opacity: controller.opacity.value,
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Assets.images.logo.image(width: 150, height: 150),
      //               SizedBox(height: 16),
      //               Text(
      //                 "My Flutter App",
      //                 style: TextStyle(fontSize: 24, color: Colors.white),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
