import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/locale/Locale_controller.dart';
import 'package:ui_ecommerce/views/Cart.dart';
import 'package:ui_ecommerce/views/Categories.dart';
import 'package:ui_ecommerce/views/Home.dart';
import 'package:ui_ecommerce/views/Profile.dart';
class Landing extends StatelessWidget {
   Landing({super.key});
   final Landing_controller controller =  Get.put(Landing_controller());
   final locale_controller = Get.put(Locale_controller());
   static  final List<Widget> _pages = <Widget>[
     Home(),
     Categories(),
     CartPage(),
     const Profile()
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.pagesViewScaffoldKey,
      drawer: Drawer(
        child: drawer(),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leadingWidth: Get.height * 0.3,
        actions: [
          actions(),
        ],
        leading: logo(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i){
          controller.onItemTapped(i);
        },
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: '14'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_outlined),
            label: '15'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            label: '16'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outlined),
            label: '17'.tr,
          ),
        ],
      ),
      body: GetBuilder<Landing_controller>(builder: (c){
        return _pages.elementAt(c.selectedIndex);
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
           spaceW(Get.height * 0.01),
           const Icon(Icons.notifications_outlined),
           spaceW(Get.height * 0.01),
            GestureDetector(
              onTap: (){
                Get.toNamed('favorites');
              },
              child: Icon(Icons.favorite_border_outlined),
            ),
           spaceW(Get.height * 0.01),
           GestureDetector(
             onTap: (){
              controller.onItemTapped(2);
             },
             child: Icon(Icons.shopping_cart_outlined),
           ),
           spaceW(Get.height * 0.01),

         ],
       ),
     );
   }
   Padding logo() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01),
       child: Row(
         children: [
           GetBuilder<Landing_controller>(builder: (builder){
             return GestureDetector(
               onTap: (){
                 builder.openDrawer();
               },
               child: const Icon(Icons.menu),
             );
           }),
           Image.asset('assets/images/logo.png' , fit: BoxFit.fill,width: Get.height * 0.06,height: Get.height * 0.03,),
           Text('0'.tr , style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: Get.height * 0.018
           ),)
         ],
       ),

     );
   }
   drawer() {
     return Container(
       color: Colors.white,
       child: ListView(
         padding: EdgeInsets.zero,
         children: [
           DrawerHeader(

               decoration: const BoxDecoration(
                 color: Colors.white,
               ),
               child: Center(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Image.asset('assets/images/logo.png' ,
                       width: Get.height * 0.2,
                       height: Get.height * 0.1,
                     ),
                     spaceH(Get.height * 0.009),
                     Text('${'2'.tr} ${controller.username}',
                       style: TextStyle(
                           fontSize: Get.height * 0.02,
                           fontWeight: FontWeight.w600
                       ),)
                   ],
                 ),
               )
           ),
           ListTile(
             leading: const Icon(Icons.home_outlined),
             title: Text('14'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(0);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.category_outlined),
             title: Text('15'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(1);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.shopping_cart_outlined),
             title: Text('16'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(2);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.view_list),
             title: Text('69'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               Get.toNamed('/billing');
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.person_outlined),
             title: Text('17'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(3);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.favorite_outline),
             title: Text('60'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               Get.toNamed('/favorites');
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.notifications_outlined),
             title: Text('61'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(0);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.call),
             title: Text('21'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {

             },
           ),
           ListTile(
             leading: const Icon(Icons.language),
             title: Text('22'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               locale_controller.changelocale();
             },
           ),
           ListTile(
             leading: const Icon(Icons.logout),
             title: Text('23'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.logou();
             },
           ),
         ],
       ),
     );
   }
}

