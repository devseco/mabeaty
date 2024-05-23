import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/controllers/Favorite_controller.dart';
import 'package:ui_ecommerce/controllers/Product_controller.dart';
import '../main.dart';
class ProductPage extends StatelessWidget {
   ProductPage({super.key});
   final Product_controller controller = Get.find();
   final Cart_controller cart_controller = Get.put(Cart_controller());
   final Favorite_controller fav_controller = Get.put(Favorite_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.transparent,
        elevation: 9.0,
        title: GetBuilder<Product_controller>(builder: (c){
         if(c.isLoadingItem.value){
           return Text('');
         }else{
           if(c.productItemList.isNotEmpty){
             return title();
           }else{
             return Text('');
           }
         }
          },
        ),
      ),
      body: GetBuilder<Product_controller>(builder: (c){
       if(c.isLoadingItem.value){
        return loading_();
       }else{
         if(c.productItemList.isNotEmpty){
           return SafeArea(
             child: ListView(
               children: [
                 sliders(),
                 line(),
                 spaceH(Get.height * 0.002),
                 _text(c.productItemList[0].title , Get.height * 0.018,Colors.black,FontWeight.bold),
                 spaceH(Get.height * 0.002),
                 _description(c.productItemList[0].description),
                 spaceH(Get.height * 0.002),
                 price(c.productItemList[0].price.toString(), c.productItemList[0].lastprice.toString()),
                 spaceH(Get.height * 0.01),
                 count_(c.productItemList[0].count, c.productItemList[0].renewable),
                  spaceH(Get.height * 0.01),
                 lowerPrice(),
                 _counter(),
                 inputPrice(),
                 spaceH(Get.height * 0.02),
                 GetBuilder<Cart_controller>(builder: (builder){
                   if(builder.isLoadingAdded.value){
                     return loading_button();
                   }else{
                     return botton();
                   }
                 })
               ],
             ),
           );
         }else{
           return Center(child: Text('20'.tr),);
         }
       }
      },),
    );
  }
  inputPrice(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.10, end: Get.width * 0.10 , top: Get.width * 0.05 ),
      child: TextField(
        onChanged: (value) {
            controller.FormatNumber(value);
        },
        style: TextStyle(
          fontSize: Get.height * 0.014,
        ),
        keyboardType:TextInputType.number,
        controller: controller.priceUser,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.1),
          ),
          hintText: 'مبلغ البيع للزبون',
          hintStyle: TextStyle(color: Colors.grey),
        ),

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ] ,

      ),
    );
  }
  msgAdded(title , msg){
    return Get.snackbar(title, msg);
  }
   loading_(){
     return Center(
       child: LoadingAnimationWidget.staggeredDotsWave(
         color: Colors.black,
         size: 80,
       ),);
   }
   loading_button(){
     return Center(
       child: LoadingAnimationWidget.staggeredDotsWave(
         color: Colors.black,
         size: 20,
       ),);
   }
   botton(){
    return GetBuilder<Cart_controller>(builder: (builder){
      return Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
             if(controller.productItemList[0].count >= 1 ){
               if(controller.priceUser.text.isNotEmpty){
                 if(int.parse(controller.priceUser.text.replaceAll(',','')) >= controller.lowerPrice){
                   builder.putDate(controller.productItemList[0].title, controller.productItemList[0].price, controller.count, controller.productItemList[0].id, controller.productItemList[0].image, controller.productItemList[0].category ,int.parse(controller.priceUser.text.replaceAll(',','')) );
                   if(!builder.isLoadingAdded.value){
                     if(builder.isAddedCart.value){
                       msgAdded('29'.tr, '30'.tr);
                     }else{
                       if(builder.isBlockAdded.value){
                         msgAdded('80'.tr, '81'.tr);
                       }else{
                         msgAdded('32'.tr, '33'.tr);
                       }
                     }
                   }else{
                     print(builder.msgAdded);
                   }
                 }else{
                   msgAdded('خطآ', 'سعر البيع المدخل اقل من السعر المحدد');
                 }
               }else{
                 msgAdded('خطآ', 'يرجى ادخال مبلغ سعر البيع للزبون');
               }
             }
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
    });
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
                      onPressed:(){
                        controller.inCounter(c.productItemList[0].count);
                      }, // زيادة الكمية
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
   lowerPrice() {
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
      child: Text( 'اقل سعر للبيع : ${formatter.format(controller.lowerPriceLabel)}',
        style: TextStyle(
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w400
        ),
      ),
    );
   }
   count_(count , renewable){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
       child: Row(
         children: [
           spaceW(Get.height * 0.009),
           Text( 'المتوفر : ${count ~/ 2} - $count',
             style: TextStyle(
                 fontSize: Get.height * 0.018,
                 fontWeight: FontWeight.w400
             ),
           ),
           spaceW(Get.height * 0.005),
       (renewable == 1)? Container(
             width: Get.height * 0.08,
             height: Get.height * 0.025,
             color: Colors.deepPurple,
             child: Center(child:  Text('قابل للتجديد' , style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: Get.height * 0.014
             ),),),
           ) : SizedBox()
         ],
       ),
     );
   }
   price(price , lastprice){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
     child: Row(
       children: [
         spaceW(Get.height * 0.009),
         Text(formatter.format(int.parse(price)) + ' '+ '18'.tr,
           style: TextStyle(
               fontSize: Get.height * 0.02,
               color: Colors.deepPurple,
               fontWeight: FontWeight.bold
           ),
         ),
         spaceW(Get.height * 0.005),
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
    return Text(controller.productItemList[0].title,
    style: TextStyle(
      fontSize: Get.height * 0.02,
      fontWeight: FontWeight.bold
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
        height: Get.height * 0.3,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white60)
          ),
          child: ClipRRect(
            child:  CarouselSlider(
              options: CarouselOptions(
                autoPlay: true
                ,viewportFraction: 1,
                height: Get.height * 0.4,
                onPageChanged: (index, reason) {
                  controller.changeindex(index);
                },
              ),
              items: controller.productItemList[0].images
                  .map((item) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white60)
                  ),
                  margin: EdgeInsets.all(Get.height * 0.005),
                  padding: EdgeInsetsDirectional.only(start: Get.height * 0.004,end: Get.height * 0.004,top: Get.height * 0.004,bottom: Get.height * 0.004),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
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
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  )
              ))
                  .toList(),
            ),
          ),
        )
      ),
    );
  }
}
