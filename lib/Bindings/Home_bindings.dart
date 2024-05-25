import 'package:get/get.dart';
import 'package:mabeaty/controllers/Home_controller.dart';

class Home_Bindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Home_controller() , fenix: true );
  }

}