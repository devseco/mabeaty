import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
           if(c.productList.isNotEmpty){
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
         if(c.productList.isNotEmpty){
           return SafeArea(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 sliders(),
                 line(),
                 spaceH(Get.height * 0.002),
                 _text(c.productList[0].title , Get.height * 0.018,Colors.black,FontWeight.bold),
                 spaceH(Get.height * 0.002),
                 _description(c.productList[0].description),
                 spaceH(Get.height * 0.002),

                 price(c.productList[0].price.toString(), c.productList[0].lastprice.toString()),
                 spaceH(Get.height * 0.01),
                 count_(c.productList[0].count, c.productList[0].renewable),

                 _counter(),
                 spaceH(Get.height * 0.08),
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
             if(controller.productList[0].count >= 1){
               builder.putDate(controller.productList[0].title, controller.productList[0].price, controller.count, controller.productList[0].id, controller.productList[0].image, controller.productList[0].category);
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
                        controller.inCounter(c.productList[0].count);
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
    return Text(controller.productList[0].title,
    style: TextStyle(
      fontSize: Get.height * 0.02,
      fontWeight: FontWeight.bold
    ),

    );
  }
  //builder.putDate(controller.productList[0].title, controller.productList[0].price, controller.productList[0].id, controller.productList[0].image, controller.productList[0].category, controller.productList[0].lastprice, controller.productList[0].rate);
   //
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
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white60)
          ),
          child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: controller.productList[0].image,
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
        )
      ),
    );
  }
}
