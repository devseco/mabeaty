import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Home extends StatelessWidget {
   Home({super.key});
  final Home_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          spaceH(Get.height * 0.015),
          Obx(() {
            if(!controller.isLoadingSliders.value){
              return (controller.slidersList.length > 0)? sliders() : placholder404();
            }else{
              return placholderSlider();
            }
          }),
          Row(
            children: [
              searchTextInput(),
              filtersIcon(),
            ],
          ),
          spaceH(Get.height * 0.02),
          bestproductslabels(),
              spaceH(Get.height * 0.02),
              Obx(() {
                if(!controller.isLoadingProductes.value){
                  if ((controller.productsList.isNotEmpty)) {
                    return recentlyproductslist();
                  } else {
                    return Center(child: Text('20'.tr),);
                  }
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              })
        ],
      )
    );
  }
   recentlyproductslist() {
     return Expanded(child: GridView.builder(
       shrinkWrap: true,
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         crossAxisSpacing: 5.0,
         mainAxisSpacing: 10.0,
         childAspectRatio: 0.89,
       ),
       itemCount: (controller.productsList.length > 12 )?  12 : controller.productsList.length,
       itemBuilder: (BuildContext context, int index) {
         final product = controller.productsList[index];
         return BestProductItem(
             product.image,
             product.title,
             product.price,
             product.id,
             product.lastprice,
             product.count,
             product.renewable
         );
       },
     ));
   }
   BestProductItem(String url , String title , int price , int id  , int lastprice , int count , int renewable){
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
   bestproductslabels() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.02),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text("12".tr , style: TextStyle(
               fontSize: Get.height * 0.02,
               fontWeight: FontWeight.bold
           ),),
           GestureDetector(
             onTap: (){
               Get.toNamed('bestProducts');

             },
             child: Text("11".tr , style: TextStyle(
                 fontSize: Get.height * 0.016,
                 fontWeight: FontWeight.w600
             ),),
           )
         ],
       ),
     );
   }
  sliders() {
    return Padding(padding: EdgeInsetsDirectional.only(top: Get.height * 0.002 , end: Get.height * 0.001 ),
      child: SizedBox(
        height:  Get.height * 0.24,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true
                ,viewportFraction: 1,
                height: Get.height * 0.2,
                onPageChanged: (index, reason) {
                  controller.changeindex(index);
                },
              ),
              items: controller.slidersList
                  .map((item) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white60)
                ),
                margin: EdgeInsets.all(Get.height * 0.002),
                padding: EdgeInsetsDirectional.only(start: Get.height * 0.004,end: Get.height * 0.004,top: Get.height * 0.004,bottom: Get.height * 0.004),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                )
              ))
                  .toList(),
            ),
            GetBuilder<Home_controller>(builder: (c){
              return DotsIndicator(
                dotsCount: controller.slidersList.length,
                position: c.index,
                decorator: DotsDecorator(
                  color: Colors.grey,
                  size: const Size.square(9.0),
                  activeSize:  Size(Get.height * 0.008, Get.height * 0.009,),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  placholderSlider(){
    return Container(
      height: Get.height * 0.3,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white60)
      ),
      margin: EdgeInsets.all(Get.height * 0.004),
      child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: const CircularProgressIndicator(),
          )
      ),
    );
  }
   placholder404(){
     return Container(
       height: Get.height * 0.3,
       width: Get.width * 0.97,
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           border: Border.all(color: Colors.white60)
       ),
       margin: EdgeInsets.all(Get.height * 0.004),
       child: Center(
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10.0),
             child: Image.asset('assets/images/comingsoon.jpg' , fit: BoxFit.fill,),
           )
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
      child: GetBuilder<Home_controller>(builder: (c){
        return EasyAutocomplete(
            decoration:  InputDecoration(
              fillColor: const Color(0xfff1ebf1),
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
            suggestions: c.productNames,
            onChanged: (value) => c.searchProducts(value),
            onSubmitted: (value) => print('onSubmitted value: $value')
        );
      },)
    ),
    );
  }
}

