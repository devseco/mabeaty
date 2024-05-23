import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/locale/Locale_controller.dart';
import 'package:ui_ecommerce/views/Billing.dart';
import 'package:ui_ecommerce/views/Cart.dart';
import 'package:ui_ecommerce/views/Categories.dart';
import 'package:ui_ecommerce/views/Home.dart';
import 'package:ui_ecommerce/views/Profile.dart';
import 'package:url_launcher/url_launcher.dart';
class Landing extends StatelessWidget {
   Landing({super.key});
   final Landing_controller controller =  Get.put(Landing_controller());
   final locale_controller = Get.put(Locale_controller());
   static final List<Widget> _pages = <Widget>[
     Home(),
     Categories(),
     Billing(),
     Profile()
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.pagesViewScaffoldKey,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leadingWidth: Get.height * 0.12,
        actions: [
          actions(),
        ],
        leading: logo(),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple, // Change to your desired color
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          controller.onItemTapped(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: '14'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_outlined),
            label: '15'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            label: '69'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outlined),
            label: '17'.tr,
          ),
        ],
      )),
      body: GetBuilder<Landing_controller>(builder: (c){
        return _pages.elementAt(c.selectedIndex.value);
      },),
    );
  }
   SizedBox spaceH(double size) {
     return SizedBox(
       height: size,
     );
   }
   SizedBox spaceW(double size) {
     return SizedBox(
       width: size,
     );
   }
   Padding actions() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01 , end: Get.height * 0.02),
       child: Row(
         children: [
           GetBuilder<Landing_controller>(builder: (c){
             return GetBuilder<Landing_controller>(
  builder: (c) {
    return GetBuilder<Landing_controller>(
      builder: (c) {
        return GestureDetector(
          onTap: () {
            Get.toNamed('cart');
          },
          child: Row(
            children: [
              c.cartItems != 0 ? Container(
                padding: EdgeInsets.all(5),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${c.cartItems}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ) : SizedBox(),
              Icon(Icons.shopping_cart_outlined, color: c.cartItems == 0 ? Colors.black : Colors.red),
            ],
          ),
        );
      },
    );

  },
     );
           }),
           spaceW(Get.height * 0.01),
         ],
       ),
     );
   }
   GestureDetector logo() {
    return GestureDetector(
      onTap: (){
        final uri = Uri.tryParse('https://linktr.ee/mabiati_iq');
        if (uri != null) {
          launchUrl(uri);
        }
      },
      child: Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.01, top: Get.height * 0.01),
        child:  Image.asset('assets/images/logo.png' , fit: BoxFit.contain,width: Get.height * 0.06,height: Get.height * 0.03,),

      ),
    );
   }
}

