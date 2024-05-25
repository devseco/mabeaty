import 'package:get/get.dart';
import 'package:mabeaty/controllers/Product_controller.dart';
class Product_bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Product_controller());
  }


}