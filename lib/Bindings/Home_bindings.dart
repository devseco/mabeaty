import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';

class Home_Bindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Home_controller());
  }

}