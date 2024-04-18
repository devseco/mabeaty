
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/BestProdcts_controller.dart';

class BestProducts_bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BestProducts_controller());
  }

}