import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/controllers/Product_controller.dart';

class Landing_bindings implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => Landing_controller());
   Get.lazyPut(() => Home_controller());
   Get.lazyPut(() => Product_controller());
  }

}