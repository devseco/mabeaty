import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        height: Get.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: Get.height * 0.05),
            SizedBox(height : Get.height * 0.012),
            Text('55'.tr,
                style: TextStyle(
                    fontSize: Get.height * 0.02
                )),
          ],
        ),
      ),
    );
  }
}
