import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Home_controller.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Home extends StatelessWidget {
   Home({super.key});
  final Home_controller controller = Get.put(Home_controller());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          spaceH(Get.height * 0.015),
          Row(
            children: [
              searchTextInput(),
              filtersIcon(),
            ],
          ),
          spaceH(Get.height * 0.01),
          Obx(() {
            if(!controller.isLoadingSliders.value){
              return (controller.slidersList.length > 0)? sliders() : placholder404();
            }else{
              return placholderSlider();
            }
          }),
              categorieslabels(),
              spaceH(Get.height * 0.030),
              Container(
                height: Get.height * 0.14,
                child: Obx((){
                  if(!controller.isLoadingCategories.value){
                    return (controller.categoriesList.length > 0 ) ? categories() : Center(child: Text("20".tr),);
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                }),
              ),
              spaceH(Get.height * 0.01),
              bestproductslabels(),
              spaceH(Get.height * 0.02),
              Obx(() {
                if(!controller.isLoadingProductes.value){
                  return (controller.productsList.value.isNotEmpty)? recentlyproductslist() : Center(child: Text('20'.tr),);
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              })

        ],
      )
    );
  }
   recentlyproductslist() {
     return GridView.builder(
       physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
       shrinkWrap: true, // You won't see infinite size error
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         crossAxisSpacing: 5.0,
         mainAxisSpacing: 10.0,
         childAspectRatio: 0.85,
       ),
       itemCount: (controller.productsList.length > 6 )?  6 : controller.productsList.length,
       itemBuilder: (BuildContext context, int index) {
         final product = controller.productsList[index];
         return BestProductItem(
           product.image,
           product.title,
           product.price,
           product.id,
           product.lastprice,
           product.rate
         );
       },
     );
   }
   BestProductItem(String url , String title , int price , int id  , int lastprice , String rate){
     return GestureDetector(
       onTap: (){
         Get.toNamed('product' , arguments:[{"id": id}],);
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
             Text(formatter.format(price).toString() + ' ' + '18'.tr , textAlign: TextAlign.start,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(
                 fontSize: Get.height * 0.0135,
                 fontWeight: FontWeight.w800,
                 color: Colors.deepPurple
               ),
             ),
             spaceH(Get.height * 0.004),
             Text(formatter.format(lastprice) + " د.ع " , textAlign: TextAlign.start,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(
                 decoration: TextDecoration.lineThrough,
                 fontWeight: FontWeight.w800,
               ),
             ),
             Row(
               children: [
                 Text('(${rate})'),
                 spaceW(Get.height * 0.005),
                 SizedBox(
                   child: RatingBar.builder(
                     initialRating: double.parse(rate),
                     minRating: 1,
                     ignoreGestures: true,
                     itemSize: 17,
                     direction: Axis.horizontal,
                     itemCount: 5,
                     allowHalfRating: true,
                     itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                     itemBuilder: (context, _) => const Icon(
                       Icons.star,
                       color: Colors.amber,
                     ),
                     onRatingUpdate: (rating) {
                       //controller.changeRate(rating);
                     },
                   ),
                 )
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

   CategoryIcon(String url , String label  , int id){
     return GestureDetector(
       onTap: (){
         Get.toNamed('/products' , arguments: [{'id':id}]);
       },
       child: Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.01,end: Get.height * 0.01),
         child: Column(
           children: <Widget>[
             Container(
               padding: EdgeInsets.all(Get.height * 0.007),
               decoration: BoxDecoration(
                   border: Border.all(color: Colors.black26),
                   borderRadius: BorderRadius.all(Radius.circular(15))
               ),
               height: Get.height * 0.07,
               width: Get.height * 0.08,
               child: CachedNetworkImage(
                 imageUrl: url,
                 imageBuilder: (context, imageProvider) => Container(
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: imageProvider,
                       fit: BoxFit.contain,
                     ),
                   ),
                 ),
                 placeholder: (context, url) => CircularProgressIndicator(),
                 errorWidget: (context, url, error) => const Icon(Icons.error),
               ),
             ),
             spaceH(Get.height * 0.01),
             Text(label),
           ],
         ),
       ),
     );
   }
  categories(){
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: (controller.categoriesList.length > 6 )?  6 : controller.categoriesList.length, // or slidersList.length, depends on your requirement
      itemBuilder: (context, index) {
        var cat = controller.categoriesList[index];
        return CategoryIcon(cat.image,cat.title , cat.id);
      },
    );
  }
  categorieslabels() {
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.02),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("10".tr , style: TextStyle(
          fontSize: Get.height * 0.02,
          fontWeight: FontWeight.bold
        ),),
        GestureDetector(
          onTap: (){
            Landing_controller c = Get.put(Landing_controller());
            c.onItemTapped(1);
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
        height: 280,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(autoPlay: true
                ,viewportFraction: 1,
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
                margin: EdgeInsets.all(Get.height * 0.004),
                padding: EdgeInsetsDirectional.only(start: Get.height * 0.004,end: Get.height * 0.004,top: Get.height * 0.004,bottom: Get.height * 0.004),
                child: Center(
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: item.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    )
                ),
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
            child: CircularProgressIndicator(),
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
    child: const Icon(Icons.search),
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


}

