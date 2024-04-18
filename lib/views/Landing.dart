import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/views/Categories.dart';
import 'package:ui_ecommerce/views/Favorites.dart';
import 'package:ui_ecommerce/views/Home.dart';
import 'package:ui_ecommerce/views/Profile.dart';
class Landing extends StatefulWidget {
   Landing({super.key});
  @override
  State<Landing> createState() => _LandingState();
}
final Landing_controller controller =  Get.find();
class _LandingState extends State<Landing> {
  static  List<Widget> _pages = <Widget>[
    Home(),
    Categories(),
    Favorites(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: controller.onItemTapped,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '14'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: '15'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '16'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '17'.tr,
          ),
        ],
      ),
      body: GetBuilder<Landing_controller>(builder: (c){
        return _pages.elementAt(c.selectedIndex);
      },),
    );
  }
}
