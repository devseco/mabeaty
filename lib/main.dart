import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_ecommerce/Bindings/Billing_bindings.dart';
import 'package:ui_ecommerce/Bindings/Checkout_bindings.dart';
import 'package:ui_ecommerce/Bindings/ItemBilling_bindings.dart';
import 'package:ui_ecommerce/Bindings/RecentlyProducts_bindings.dart';
import 'package:ui_ecommerce/Bindings/Cart_bindings.dart';
import 'package:ui_ecommerce/Bindings/Category_bindings.dart';
import 'package:ui_ecommerce/Bindings/Home_bindings.dart';
import 'package:ui_ecommerce/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/Bindings/Product_bindings.dart';
import 'package:ui_ecommerce/Bindings/Products_bindings.dart';
import 'package:ui_ecommerce/controllers/Favorite_controller.dart';
import 'package:ui_ecommerce/locale/Locale_controller.dart';
import 'package:ui_ecommerce/locale/locale.dart';
import 'package:ui_ecommerce/middleware/auth_middleware.dart';
import 'package:ui_ecommerce/models/CartModel.dart';
import 'package:ui_ecommerce/models/FavoriteModel.dart';
import 'package:ui_ecommerce/views/Billing.dart';
import 'package:ui_ecommerce/views/Checkout.dart';
import 'package:ui_ecommerce/views/Favorites.dart';
import 'package:ui_ecommerce/views/Item_Billing.dart';
import 'package:ui_ecommerce/views/RecentlyProducts.dart';
import 'package:ui_ecommerce/views/Cart.dart';
import 'package:ui_ecommerce/views/Categories.dart';
import 'package:ui_ecommerce/views/Home.dart';
import 'package:ui_ecommerce/views/Landing.dart';
import 'package:ui_ecommerce/views/Login.dart';
import 'package:ui_ecommerce/views/ProductPage.dart';
import 'package:ui_ecommerce/views/Products.dart';
import 'package:ui_ecommerce/views/RegisterView.dart';
import 'controllers/Cart_controller.dart';
import 'package:intl/intl.dart';
SharedPreferences? sharedPreferences;
var formatter = NumberFormat("#,###");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());
  BoxCart = await Hive.openBox<CartModel>('Cart');
  BoxFavorite = await Hive.openBox<FavoriteModel>('Favorite');
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
        fontFamily: 'Tajawal',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      initialBinding: Landing_bindings(),
      getPages: [
        GetPage(name: '/', page: ()=>  Login() ,binding: Landing_bindings(),middlewares: [auth_middleware()]),
        GetPage(name: '/product', page: ()=>  ProductPage() ,binding: Product_bindings()),
        GetPage(name: '/landing', page: ()=>  Landing() ,binding: Landing_bindings()),
        GetPage(name: '/home', page: ()=>  Home() , binding: Home_Bindings()),
        GetPage(name: '/bestProducts', page: ()=>RecentlyProducts() , binding: RecentlyProducts_bindings()),
        GetPage(name: '/cart', page: ()=>CartPage() , binding: Cart_bindings()),
        GetPage(name: '/categories', page: ()=>Categories() , binding: Category_bindings()),
        GetPage(name: '/products', page: ()=>Products() , binding: Products_bindings()),
        GetPage(name: '/checkout', page: ()=>Checkout() , binding: Checkout_bindings()),
        GetPage(name: '/favorites', page: ()=>Favorites() , binding: Checkout_bindings()),
        GetPage(name: '/billing', page: ()=>Billing() , binding: Billing_bindings()),
        GetPage(name: '/Item_Billing', page: ()=>Item_Billing() , binding: ItemBilling_bindings()),
        GetPage(name: '/register', page: ()=>RegisterView() , binding: Landing_bindings()),
      ],
    );
  }
}
