import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/Bindings/BestProducts_bindings.dart';
import 'package:ui_ecommerce/Bindings/Home_bindings.dart';
import 'package:ui_ecommerce/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/Bindings/Login_bindings.dart';
import 'package:ui_ecommerce/Bindings/Product_bindings.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/controllers/Locale_controller.dart';
import 'package:ui_ecommerce/views/BestProducts.dart';
import 'package:ui_ecommerce/views/Home.dart';
import 'package:ui_ecommerce/views/Landing.dart';
import 'package:ui_ecommerce/views/Login.dart';
import 'package:ui_ecommerce/views/ProductPage.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Locale_controller(),
      locale: Get.deviceLocale,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>  Login() ,binding: Login_Bindings()),
        GetPage(name: '/product', page: ()=>  ProductPage() ,binding: Product_bindings()),
        GetPage(name: '/landing', page: ()=>  Landing() ,binding: Landing_bindings()),
        GetPage(name: '/home', page: ()=>  Home() , binding: Home_Bindings()),
        GetPage(name: '/bestProducts', page: ()=>BestProducts() , binding: BestProducts_bindings()),
      ],
    );
  }
}
