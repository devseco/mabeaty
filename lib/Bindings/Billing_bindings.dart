import 'package:get/get.dart';
import 'package:mabeaty/controllers/Billing_controller.dart';

class Billing_bindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Billing_controller());
    // TODO: implement dependencies
  }

}