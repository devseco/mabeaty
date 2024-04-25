import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Checkout_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Payment extends StatelessWidget {
  Payment({super.key});
  Checkout_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          message(),
          paymentlist(),
          order('ali',30000,5000,35000),
        ],
      ),
    );
  }
   line() {
     return const Divider(
       color: Colors.black12,
     );
   }
   order(name , price , delivery ,total){
     return Padding(
       padding: EdgeInsetsDirectional.only(start: Get.height * 0.01 , end: Get.height * 0.01 , top: Get.height * 0.02 , bottom: Get.height * 0.02),
       child: Container(
         width: Get.width,
         height: Get.height * 0.2,
         padding:  EdgeInsets.all(Get.height * 0.015),
         decoration: BoxDecoration(
             borderRadius: BorderRadius.all(
                 Radius.circular(Get.height * 0.015) //                 <--- border radius here
             ),
             border: Border.all(color: Colors.grey , width: 0.5)
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('${'50'.tr}' , style: TextStyle(
               fontWeight: FontWeight.w700,
               fontSize: Get.height * 0.018
             ),),
             spaceH(Get.height * 0.035),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'47'.tr} : ' , style: TextStyle(
                     fontSize: Get.height * 0.015,
                     fontWeight: FontWeight.w500,
                 ),),
             Text('${formatter.format(price)} ${'18'.tr}', style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.w500,
                 ),),
               ],
             ),
             spaceH(Get.height * 0.015),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'48'.tr} : ' , style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.w500,
                 ),),
                 Text('${formatter.format(delivery)} ${'18'.tr}' , style: TextStyle(
                     fontWeight: FontWeight.w500,
                   fontSize: Get.height * 0.015,
                 ),),
               ],
             ),
             spaceH(Get.height * 0.015),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'49'.tr} : ' , style: TextStyle(
                     fontWeight: FontWeight.w800,
                     fontSize: Get.height * 0.015,
                 ),),
                 Text('${formatter.format(total)} ${'18'.tr}' , style: TextStyle(
                   fontWeight: FontWeight.w800,
                   fontSize: Get.height * 0.015,
                 ),),
               ],
             ),
           ],
         ),
       ),
     );
   }
  paymentlist(){
    return Padding(
      padding: EdgeInsetsDirectional.only(start: Get.height * 0.00001),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title:  Row(
            children: [
              Text('38'.tr),
              spaceW(Get.height * 0.01),
              FaIcon(FontAwesomeIcons.moneyBill , color: Colors.black,)
            ],
          ),
          leading: Radio<int>(
            value: 1,
            activeColor: Colors.blue,
            groupValue: 1,
            onChanged: (value) {

            },
          ),
        ),
        paymenytile('39'.tr , FontAwesomeIcons.creditCard),
        paymenytile('40'.tr , FontAwesomeIcons.apple),
        paymenytile('41'.tr , FontAwesomeIcons.google),
      ],
    ),
    );
  }
  paymenytile(title , icone){
    return ListTile(
      title:  Row(
        children: [
          Text(title),
          spaceW(Get.height * 0.01),
          FaIcon(icone,color: Colors.black,)
        ],
      ),
      leading: Radio<int>(
        value: 2,
        activeColor: Colors.deepPurple,
        groupValue: 1,
        onChanged: (value) {
          Get.snackbar('42'.tr, '43'.tr);
        },
      ),
    );
  }
   message(){
     return Padding(
       padding: EdgeInsetsDirectional.only(start: Get.height * 0.033 , end: Get.height * 0.033 , bottom: Get.height * 0.01,),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           Text('36'.tr,
             textAlign: TextAlign.start,
             style: TextStyle(
                 fontSize: Get.height * 0.02,
                 fontWeight: FontWeight.w700
             ),

           ),
           spaceH(Get.height * 0.01),
           Text('37'.tr,
             textAlign: TextAlign.start,
             style: TextStyle(
                 fontSize: Get.height * 0.016,
                 fontWeight: FontWeight.w500
             ),

           ),
           spaceH(Get.height * 0.01),
           line(),
         ],
       ),
     );
   }
   title(){
     return Text('31'.tr,
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
}
