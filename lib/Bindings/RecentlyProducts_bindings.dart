import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/RecentlyProducts_controller.dart';
class RecentlyProducts_bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentlyProducts_controller());
  }
}