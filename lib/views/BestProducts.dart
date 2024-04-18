import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/BestProdcts_controller.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
class BestProducts extends StatelessWidget {
   BestProducts({super.key});
 final BestProducts_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: Get.height * 0.3,
        actions: [
          actions(),
        ],
        leading: logo(),
      ),
      body: SafeArea(
          child: Column(
            children: [
              spaceH(Get.height * 0.015),
              Row(
                children: [
                  searchTextInput(),
                  filtersIcon(),
                ],
              ),
              spaceH(Get.height * 0.015),
              Expanded(child: bestproductslist())
            ],

          )),
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
  Padding logo() {
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          Image.asset('assets/images/logo.png' , fit: BoxFit.fill,width: Get.height * 0.06,height: Get.height * 0.03,),
          Text('Apple Store' , style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.height * 0.018
          ),)
        ],
      ),

    );
  }
  Padding actions() {
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01 , end: Get.height * 0.02),
      child: Row(
        children: [
          spaceW(Get.height * 0.01),
          const Icon(Icons.favorite_border_outlined),
          spaceW(Get.height * 0.01),
          const Icon(Icons.shopping_cart_outlined),
          spaceW(Get.height * 0.01),

        ],
      ),
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

            decoration:  InputDecoration(
              fillColor: Color(0xfff1ebf1),
              filled: true,
              prefixIcon: const Icon(Icons.search),
              hintText: '9'.tr,
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
  bestproductslist() {
    return GridView.builder(
      padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009),
    // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.8,
      ),
      itemCount: controller.productList.length,
      itemBuilder: (BuildContext context, int index) {
        final product = controller.productList[index];
        return BestProductItem(
          product.image!,
          product.title!,
          product.price!,
        );
      },
    );
  }
   BestProductItem(String url , String title , int price  ){
     return Container(
       height: 210,
       padding: EdgeInsets.all(Get.height * 0.017),
       width: Get.height * 0.2,
       decoration: BoxDecoration(
           border: Border.all(color: Colors.black12),
           borderRadius: BorderRadius.all(Radius.circular(15))
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Icon(Icons.favorite_border_outlined),
           Center(
             child:  CachedNetworkImage(
               height: Get.height * 0.12,
               width: Get.height * 0.18,
               imageUrl: url,
               imageBuilder: (context, imageProvider) => Container(
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: imageProvider,
                     fit: BoxFit.cover,
                   ),
                 ),
               ),
               placeholder: (context, url) => CircularProgressIndicator(),
               errorWidget: (context, url, error) => const Icon(Icons.error),
             ),
           ),
           spaceH(Get.height * 0.01),
           Text(title , textAlign: TextAlign.start,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
               fontWeight: FontWeight.bold,

             ),
           ),
           spaceH(Get.height * 0.004),
           Text(price.toString() + " د.ع " , textAlign: TextAlign.start,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
               fontWeight: FontWeight.w800,
             ),
           ),
         ],
       ),
     );
   }
}
