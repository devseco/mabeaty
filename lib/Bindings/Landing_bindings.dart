import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Favorite_controller.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/controllers/Login_controller.dart';
import '../controllers/Cart_controller.dart';
class Landing_bindings implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => Landing_controller(),fenix: true);
   Get.lazyPut(() => Login_controller(),fenix: true);
   Get.lazyPut<Home_controller>(() => Home_controller() ,fenix: true);
   Get.lazyPut(() => Cart_controller() , fenix: true);
   Get.lazyPut(() => Favorite_controller() , fenix: true);
  }
}