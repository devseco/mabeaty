import 'package:get/get.dart';
import 'package:mabeaty/controllers/RecentlyProducts_controller.dart';
class RecentlyProducts_bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentlyProductsController());
  }
}