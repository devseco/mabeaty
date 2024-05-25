import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mabeaty/Bindings/Billing_bindings.dart';
import 'package:mabeaty/Bindings/Checkout_bindings.dart';
import 'package:mabeaty/Bindings/ItemBilling_bindings.dart';
import 'package:mabeaty/Bindings/RecentlyProducts_bindings.dart';
import 'package:mabeaty/Bindings/Cart_bindings.dart';
import 'package:mabeaty/Bindings/Category_bindings.dart';
import 'package:mabeaty/Bindings/Home_bindings.dart';
import 'package:mabeaty/Bindings/Landing_bindings.dart';
import 'package:mabeaty/Bindings/Product_bindings.dart';
import 'package:mabeaty/Bindings/Products_bindings.dart';
import 'package:mabeaty/controllers/Favorite_controller.dart';
import 'package:mabeaty/locale/Locale_controller.dart';
import 'package:mabeaty/locale/locale.dart';
import 'package:mabeaty/middleware/auth_middleware.dart';
import 'package:mabeaty/models/CartModel.dart';
import 'package:mabeaty/models/FavoriteModel.dart';
import 'package:mabeaty/views/Billing.dart';
import 'package:mabeaty/views/Checkout.dart';
import 'package:mabeaty/views/Favorites.dart';
import 'package:mabeaty/views/Item_Billing.dart';
import 'package:mabeaty/views/RecentlyProducts.dart';
import 'package:mabeaty/views/Cart.dart';
import 'package:mabeaty/views/Categories.dart';
import 'package:mabeaty/views/Home.dart';
import 'package:mabeaty/views/Landing.dart';
import 'package:mabeaty/views/Login.dart';
import 'package:mabeaty/views/ProductPage.dart';
import 'package:mabeaty/views/Products.dart';
import 'package:mabeaty/views/RegisterView.dart';
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
