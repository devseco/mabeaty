import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabeaty/controllers/Category_controller.dart';

class Categories extends StatelessWidget {
   Categories({super.key});
   final Category_controller controller = Get.put(Category_controller());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Column(

            children: [
              spaceH(Get.height * 0.015),
              Expanded(child: bestproductslist())
            ],

          )),

    );
  }
   bestproductslist() {
     return GridView.builder(
       padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009),
       // to disable GridView's scrolling
       shrinkWrap: true, // You won't see infinite size error
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         childAspectRatio: 0.95,
         crossAxisCount: 2,
         crossAxisSpacing: 10.0,
         mainAxisSpacing: 15.0,
       ),
       itemCount: controller.categoriesList.length,
       itemBuilder: (BuildContext context, int index) {
         final Category = controller.categoriesList[index];
         return CategoryItem(
             Category.image,
             Category.title,
             Category.id
         );
       },
     );
   }
   CategoryItem(String url , String title  , int index){
     return GestureDetector(
       onTap: (){
         Get.toNamed('/products' , arguments: [{'id':index}]);
       },
       child: Container(
         padding: EdgeInsets.all(Get.height * 0.017),
         width: Get.height * 0.2,
         decoration: BoxDecoration(
             border: Border.all(color: Colors.black12),
             borderRadius: BorderRadius.all(Radius.circular(15))
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             spaceH(Get.height * 0.02),
             Center(
               child:  CachedNetworkImage(
                 height: Get.height * 0.12,
                 width: Get.height * 0.18,
                 imageUrl: url,
                 imageBuilder: (context, imageProvider) => Container(
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: imageProvider,
                       fit: BoxFit.scaleDown,
                     ),
                   ),
                 ),
                 placeholder: (context, url) => CircularProgressIndicator(),
                 errorWidget: (context, url, error) => const Icon(Icons.error),
               ),
             ),
             spaceH(Get.height * 0.01),
             Center(
               child: Text(title , textAlign: TextAlign.start,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                   fontWeight: FontWeight.bold,

                 ),
               ),
             )
           ],
         ),
       ),
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
   Padding filtersIcon (){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.009 , end: Get.height * 0.009),
       child: const Icon(Icons.tune),
     );
   }
   Padding searchTextInput() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.002),
       child: SizedBox(
           width: Get.width * 0.83,
           child: TextField(
             controller: controller.myController,
             decoration:  InputDecoration(
               fillColor: Color(0xfff1ebf1),
               filled: true,
               prefixIcon: const Icon(Icons.search),
               hintText: '27'.tr,
               enabledBorder: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 borderSide:  BorderSide(
                   color: Color(0xfff1ebf1),
                 ),
               ),
               focusedBorder: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 borderSide: BorderSide(color:Color(0xfff1ebf1),),
               ),
             ),
           )),
     );
   }
}
