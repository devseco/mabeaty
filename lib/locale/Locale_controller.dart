import 'dart:ui';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Locale_controller extends GetxController {
  Locale inliaLang = sharedPreferences!.getString('lang') == 'ar' ? Locale('ar') : Locale('en');
  void changelocale() {
    if(Get.locale.toString().contains('ar')){
      Locale locale = Locale('en');
      sharedPreferences!.setString('lang', 'en');
      Get.updateLocale(locale);
    }else{
      Locale locale = Locale('ar');
      sharedPreferences!.setString('lang', 'ar');
      Get.updateLocale(locale);
    }
  }
}