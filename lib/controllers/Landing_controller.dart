import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/views/Login.dart';
import '../main.dart';
class Landing_controller extends GetxController{
  RxInt selectedIndex = 0.obs;
  var username  = sharedPreferences!.getString('name').toString();
  var phone  = sharedPreferences!.getInt('phone').toString();
  var cartItems = 0;
  void onItemTapped(int index) {
    selectedIndex.value = index;
    print('tap: ${index}');
    update();
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var pagesViewScaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    pagesViewScaffoldKey.currentState?.openDrawer();
    update();
  }
  void closeDrawer() {
    pagesViewScaffoldKey.currentState?.closeDrawer();
    update();
  }
  void logout(){
    sharedPreferences!.clear();
    //BoxCart.clear();
    Get.off(() => Login());
  }
  void setCount(){
    int count = BoxCart.length;
    cartItems = count;
    update();
  }
  @override
  void onInit() {
    setCount();
    // TODO: implement onInit
    super.onInit();
  }
}