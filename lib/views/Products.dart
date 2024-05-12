import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/controllers/Products_controller.dart';
import '../main.dart';
class Products extends StatelessWidget {
   Products({super.key});
   final Products_Controller controller = Get.put(Products_Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: Get.height * 0.2,

        leading: logo(),
      ),
      body: Column(
        children: [
          spaceH(Get.height * 0.015),
          Row(
            children: [
              searchTextInput(),
              filtersIcon(),
            ],
          ),
          spaceH(Get.height * 0.015),
          GetBuilder<Products_Controller>(builder: (builder){
            if(!builder.isLoadingItem.value){
              if(builder.productList.isNotEmpty){
                return Expanded(child: ItemsList());
              }else{
                return Center(child: Text('20'.tr),);
              }
            }else{
              return  loading_();
            }
          }
          )
        ],
      ),
    );
  }
   loading_(){
     return Center(
       child: LoadingAnimationWidget.staggeredDotsWave(
         color: Colors.black,
         size: 80,
       ),);
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
  ItemsList() {
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
        return Item(
          product.image,
          product.title,
          product.price,
          product.id,
          product.lastprice,
          product.count,
          product.renewable
        );
      },
    );
  }
   Item(String url , String title , int price , int id  , int lastprice , int count , int renewable){
     return GestureDetector(
       onTap: (){
         Get.toNamed('product' , arguments:[{"id": id}],);
       },
       child: Container(
         padding: EdgeInsets.all(Get.height * 0.017),
         width: Get.height * 0.2,
         decoration: BoxDecoration(
             border: Border.all(color: Colors.black12),
             borderRadius: const BorderRadius.all(Radius.circular(15))
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Center(
               child:  CachedNetworkImage(
                 height: Get.height * 0.12,
                 width: Get.height * 0.18,
                 imageUrl: url,
                 imageBuilder: (context, imageProvider) => Container(
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: imageProvider,
                       fit: BoxFit.contain,
                     ),
                   ),
                 ),
                 placeholder: (context, url) => const CircularProgressIndicator(),
                 errorWidget: (context, url, error) => const Icon(Icons.error),
               ),
             ),
             spaceH(Get.height * 0.01),
             Text(title , textAlign: TextAlign.start,
               overflow: TextOverflow.ellipsis,
               style: const TextStyle(
                 fontWeight: FontWeight.bold,
               ),
             ),
             spaceH(Get.height * 0.004),
             Text('${formatter.format(price)}  ${'18'.tr}'  , textAlign: TextAlign.start,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(
                   fontSize: Get.height * 0.0135,
                   fontWeight: FontWeight.w800,
                   color: Colors.deepPurple
               ),
             ),
             spaceH(Get.height * 0.004),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   'المتوفر : ${count ~/ 2} - $count',
                   textAlign: TextAlign.start,
                   style: const TextStyle(
                     color: Colors.black45,
                     fontWeight: FontWeight.w800,
                   ),
                 ),
                 Text(
                   (renewable == 1) ? 'قابل للتجديد' : '',
                   textAlign: TextAlign.start,
                   style: const TextStyle(
                     color: Colors.deepPurple,
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ],
             )
           ],
         ),
       ),
     );
   }
}
