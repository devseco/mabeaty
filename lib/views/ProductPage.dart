import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Product_controller.dart';
class ProductPage extends StatelessWidget {
   ProductPage({super.key});
  final Product_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.transparent,
        actions: [
          actions(),
        ],
        elevation: 9.0,
        title: title(),

      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sliders(),
            spaceH(Get.height * 0.002),
            _text("Xbox Serias X 2020" , Get.height * 0.018,Colors.black,FontWeight.bold),
            spaceH(Get.height * 0.002),
            _description('Simple Description For this Products For sale now online Simple Description For this Products For sale now online Simple Description For this Products For sale now '),
            spaceH(Get.height * 0.002),
            rate(),
            spaceH(Get.height * 0.002),
            price(),
            spaceH(Get.height * 0.01),
            _counter(),
            spaceH(Get.height * 0.08),
            bottom()
          ],
        ),

      ),
    );
  }
   bottom(){
    return Center(
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            //add_cart(items[0]['id'], id, items[0]['image'], quantity.toString(), items[0]['title'], items[0]['price']);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20), // Rounded corners
            ),
            minimumSize: Size(200, 60), // Set the button's size
          ),
          child: Text('19'.tr,
              style: TextStyle(color: Colors.white,
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.bold

              )),
        ),
      ),
    );
   }
  _counter(){
    return Center(
      child: GetBuilder<Product_controller>(builder: (c){
        return Container(
          padding: EdgeInsets.only(top: Get.height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container( // مسافة داخلية حول الأيقونات والنص
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // لون الإطار
                  borderRadius: BorderRadius.circular(10.0), // تقريب زوايا الإطار
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: controller.outCounter, // تقليل الكمية
                    ),
                    GetBuilder<Product_controller>(builder: (builder){
                      return Text(
                        '${builder.count}', // عرض الكمية
                        style: TextStyle(fontSize: 20),
                      );
                    }),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: controller.inCounter, // زيادة الكمية
                    ),
                  ],
                ),
              ),
            ],
          ),

        );
      }),
    );
  }
   _description(String des){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.05),
       child: Text(des,
         textAlign: TextAlign.start,
         maxLines: 5,
         style: TextStyle(
             fontSize: Get.height * 0.014,
             fontWeight: FontWeight.w300,
             height: 1.5,

             color : const Color(0xff757D75),
         ),
       ),
     );
   }
   price(){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
     child: Row(
       children: [
         Text("200,000" + ' '  + '18'.tr,
           style: TextStyle(
               decoration: TextDecoration.lineThrough,
               fontSize: Get.height * 0.015,
               color: Colors.grey,
               fontWeight: FontWeight.bold
           ),
         ),
         spaceW(Get.height * 0.005),
         Text("100,000" + ' '+ '18'.tr,
           style: TextStyle(
               fontSize: Get.height * 0.02,
               fontWeight: FontWeight.bold
           ),
         ),
         spaceW(Get.height * 0.005),
         Container(
           width: Get.height * 0.06,
           height: Get.height * 0.025,
           color: Colors.redAccent,
           child: Center(child: Text("Offer" , style: TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.bold,
             fontSize: Get.height * 0.013
           ),),),
         )

       ],
     ),
     );
   }
   rate(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
    child: Row(
      children: [
        Text('(${controller.rate})'),
        spaceW(Get.height * 0.005),
        SizedBox(
          child: RatingBar.builder(
            initialRating: controller.rate,
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
              controller.changeRate(rating);
            },
          ),
        )
      ],
    ),

    );
   }
   _text(String title , double size , Color color , FontWeight fontWeight){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
     child: Text(title,
       textAlign: TextAlign.start,
       style: TextStyle(
           fontSize: size,
           fontWeight: fontWeight,
           color : color
       ),
     ),
     );
   }
  title(){
    return Text("Product Title",
    style: TextStyle(
      fontSize: Get.height * 0.02,
      fontWeight: FontWeight.bold
    ),

    );
  }
  Padding actions() {
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01 , end: Get.height * 0.02),
      child: Row(
        children: [
          const Icon(Icons.more_vert),
          spaceW(Get.height * 0.01),

        ],
      ),
    );
  }
  line() {
    return const Divider(
      color: Colors.black12,
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
  sliders() {
    return Padding(padding: EdgeInsetsDirectional.only(top: Get.height * 0.007),
      child: SizedBox(
        height: Get.height * 0.303,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(autoPlay: true
                ,viewportFraction: 1,
            onPageChanged: (index, reason) {
              controller.changeindex(index);
            },
              ),
              items: controller.imgList
                  .map((item) => Container(

                decoration: BoxDecoration(

                    border: Border.all(color: Colors.white60)
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: item,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ))
                  .toList(),
            ),
            GetBuilder<Product_controller>(builder: (c){
              return DotsIndicator(
                dotsCount: controller.imgList.length,
                position: c.index,
                decorator: DotsDecorator(
                  color: Colors.grey,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
            line(),
          ],
        )
      ),
    );
  }
}
