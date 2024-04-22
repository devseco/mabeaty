import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_ecommerce/Bindings/BestProducts_bindings.dart';
import 'package:ui_ecommerce/Bindings/Cart_bindings.dart';
import 'package:ui_ecommerce/Bindings/Home_bindings.dart';
import 'package:ui_ecommerce/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/Bindings/Login_bindings.dart';
import 'package:ui_ecommerce/Bindings/Product_bindings.dart';
import 'package:ui_ecommerce/locale/Locale_controller.dart';
import 'package:ui_ecommerce/locale/locale.dart';
import 'package:ui_ecommerce/middleware/auth_middleware.dart';
import 'package:ui_ecommerce/models/CartModel.dart';
import 'package:ui_ecommerce/views/BestProducts.dart';
import 'package:ui_ecommerce/views/Cart.dart';
import 'package:ui_ecommerce/views/Home.dart';
import 'package:ui_ecommerce/views/Landing.dart';
import 'package:ui_ecommerce/views/Login.dart';
import 'package:ui_ecommerce/views/ProductPage.dart';
import 'controllers/Cart_controller.dart';
import 'package:intl/intl.dart';
SharedPreferences? sharedPreferences;
var formatter = NumberFormat("#,###");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  BoxCart = await Hive.openBox<CartModel>('Cart');
  runApp(const MyApp());
}
Locale_controller locale_controller = Get.put(Locale_controller());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: locale(),
      locale: locale_controller.inliaLang,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>  Login() ,binding: Login_Bindings(),middlewares: [auth_middleware()]),
        GetPage(name: '/product', page: ()=>  ProductPage() ,binding: Product_bindings()),
        GetPage(name: '/landing', page: ()=>  Landing() ,binding: Landing_bindings()),
        GetPage(name: '/home', page: ()=>  Home() , binding: Home_Bindings()),
        GetPage(name: '/bestProducts', page: ()=>BestProducts() , binding: BestProducts_bindings()),
        GetPage(name: '/cart', page: ()=>CartPage() , binding: Cart_bindings()),
      ],
    );
  }
}
