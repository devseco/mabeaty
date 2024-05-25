import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabeaty/controllers/ProfileController.dart';
import 'package:mabeaty/main.dart';
class Profile extends StatelessWidget {
   Profile({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (builder){
        if(!builder.isLoadingUser.value){
          if(builder.userList.isNotEmpty){
            return Container(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  imagePerson(),
                  namePerson(),
                  statusPerson(),
                  userInfo(),
                  statusOrders(),
                  settingUser(),
                ],
              ),
            );
          }else{
            return Center(child: Text('لا توجد بيانات حاليا'),);
          }
        }else{
          return Center(child: CircularProgressIndicator(),);

        }
      },),
    );
  }
  Widget settingUser(){
    return Container(
      margin: EdgeInsets.only(top: Get.width * 1 , right: Get.width * 0.05 ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.width * 0.10,
            ),
           GetBuilder<ProfileController>(builder: (builder){
             return GestureDetector(
               onTap: (){
                 if(builder.userList[0].summary.totalLoss >= 10000){
                   dialogPayment();
                 }else{
                   Get.snackbar('خطآ', 'يجب ان يكون مبلغ القاصة اكبر او يساوي 10,000 دينار عراقي');
                 }

               },
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Icon(Icons.request_page , size: Get.width * 0.04,),
                   SizedBox(width: Get.width * 0.015,),
                   Text(
                     'طلب حساب',
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: Get.width * 0.04,
                         fontWeight: FontWeight.w500
                     ),
                   ),
                 ],
               ),
             );
           }),
            SizedBox(
              height: Get.width * 0.06,
            ),
            GestureDetector(
              onTap: (){
                showConfirmationPrompt();
                //profileController.logout();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.delete , size: Get.width * 0.04,color: Colors.redAccent,),
                  SizedBox(width: Get.width * 0.015,),
                  Text(
                    'حذف الحساب',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.width * 0.06,
            ),

            GestureDetector(
              onTap: (){
                profileController.logout();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.logout , size: Get.width * 0.04,),
                  SizedBox(width: Get.width * 0.015,),
                  Text(
                    'تسجيل خروج',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.width * 0.1,
            ),
            Text(
              'برمجة وتصميم علي سيكو',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.w500
              ),
            ),

          ],
        ),
      ),
    );
  }
   void showConfirmationPrompt() {
     Get.defaultDialog(
       title: "حذف الحساب",
       middleText: "هل انت متآكد من ارسال طلب حذف الحساب",
       actions: [
         TextButton(
           onPressed: () {
             profileController.deleteAccount();
           },
           child: Text("ارسال"),
         ),
         TextButton(
           onPressed: () {
             Get.back(); // Close the dialog
           },
           child: Text("الغاء"),
         ),
       ],
     );
   }
  Widget statusOrders(){
    return GetBuilder<ProfileController>(builder: (builder){
      return Container(
        width: Get.width,
        height: Get.width * 0.45,
        margin: EdgeInsets.only(top: Get.width * 0.6),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              padding:
                              EdgeInsets.only(top: Get.width * 0.04, bottom: Get.width * 0.01 ),
                              child:  Text("القاصة",
                                  style:  TextStyle(
                                      color: Colors.black ,
                                      fontSize: Get.width * 0.03,
                                      fontWeight: FontWeight.bold

                                  ))),
                          Container(
                              padding: const EdgeInsets.only(bottom: 15),
                              child:  Text('${formatter.format(builder.userList[0].summary.totalLoss)} د.ع '  ,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: Get.width * 0.04,

                                  ))),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              padding:
                              EdgeInsets.only(top: Get.width * 0.04, bottom: Get.width * 0.01 ),
                              child:  Text("الارباح المتوقعة",
                                  style:  TextStyle(
                                      color: Colors.black ,
                                      fontSize: Get.width * 0.03,
                                      fontWeight: FontWeight.bold

                                  ))),
                          Container(
                              padding: const EdgeInsets.only(bottom: 15),
                              child:  Text('${formatter.format(builder.userList[0].summary.totalExpectedProfit)} د.ع '  ,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: Get.width * 0.04,

                                  ))),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              padding:
                              EdgeInsets.only(top: Get.width * 0.04, bottom: Get.width * 0.01 ),
                              child:  Text("الرواجع",
                                  style:  TextStyle(
                                      color: Colors.black ,
                                      fontSize: Get.width * 0.03,
                                      fontWeight: FontWeight.bold

                                  ))),
                          Container(
                              padding: const EdgeInsets.only(bottom: 15),
                              child:  Text('${formatter.format(builder.userList[0].summary.totalReturnedOrders)} د.ع '  ,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: Get.width * 0.04,

                                  ))),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              padding:
                              EdgeInsets.only(top: Get.width * 0.04, bottom: Get.width * 0.004 ),
                              child:  Text("الارباح المستلمة",
                                  style:  TextStyle(
                                      color: Colors.black54,
                                      fontSize: Get.width * 0.03,
                                      fontWeight: FontWeight.bold

                                  ))),
                          Container(
                              padding: const EdgeInsets.only(bottom: 15),
                              child:  Text('${formatter.format(builder.userList[0].summary.totalReceivedProfit)} ${'18'.tr}',
                                  style:  TextStyle(
                                      color: Colors.orange,
                                      fontSize: Get.width * 0.04
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ],
              )
          ),
        ),
      );
    });
  }
  Widget userInfo(){
    return Padding(padding: EdgeInsets.only(top: Get.width * 0.40 , right: Get.width * 0.02),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.call , size: Get.width * 0.04,),
            SizedBox(width: Get.width * 0.015,),
            Text(
              '${profileController.userList[0].userInfo.phone}',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),

        SizedBox(height: Get.width * 0.03,),
        Row(
          children: [
            Icon(Icons.location_on_outlined , size: Get.width * 0.04,),
            SizedBox(width: Get.width * 0.015,),
            Text(
              '${profileController.userList[0].userInfo.city} - ${profileController.userList[0].userInfo.address}',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ],
    ),

    );
  }


  Widget imagePerson() {
    return PositionedDirectional(
      top: Get.width * 0.02,
      start: Get.width * 0.02,
      child: Image.asset(
        'assets/images/person.png',
        height: Get.width * 0.30,
        fit: BoxFit.contain,
      ),
    );
  }
  Widget namePerson() {
    return PositionedDirectional(
      top: Get.width * 0.2,
      start: Get.width * 0.35,
      child: Text(
          '${profileController.userList[0].userInfo.name}',
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: Get.width * 0.05,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
  Widget statusPerson() {
    return PositionedDirectional(
      top: Get.width * 0.05,
      end: Get.width * 0.1,
      child: Row(
        children: [
          (profileController.userList[0].userInfo.active == 1)? Icon(Icons.check_circle , color: Colors.green,) : Icon(Icons.check_circle , color: Colors.red,),
    SizedBox(width: Get.width * 0.01,),
          (profileController.userList[0].userInfo.active == 1)? Text(
              'موثق',
            style: TextStyle(
              color:Colors.green,
              fontWeight: FontWeight.bold
            ),
          ) : Text(
            'غير موثق',
            style: TextStyle(
                color:Colors.red,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
  dialogPayment(){
      return Get.dialog(
          barrierDismissible: true,
          Dialog(
            child: Container(
              height: Get.width * 1.2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Text("اختر طريقة السحب"),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Obx(() => SizedBox(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'اختر طريقة الدفع', // هذا هو النص التلميحي
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: profileController.selectedPaymentMethod.value,
                      onChanged: (newValue) {
                        profileController.selectedPaymentMethod.value = newValue!;
                      },
                      items: profileController.paymentMethods.map((paymentMethod) {
                        return DropdownMenuItem(
                          value: paymentMethod,
                          child: Text(paymentMethod.tr), // استخدم .tr للترجمة إذا كنت تستخدم الترجمة
                        );
                      }).toList(),
                    ),
                  )),
                  SizedBox(height: Get.width * 0.05,),
                  TextField(
                    controller: profileController.payment_number,
                    decoration: InputDecoration(
                      labelText: 'رقم البطاقة'.tr,
                      border: OutlineInputBorder(), // هذا يضيف حد مستطيل
                    ),
                    keyboardType: TextInputType.number,
                  ),
                   SizedBox(height: Get.width * 0.05,),
                  TextField(
                    controller: profileController.payment_name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'اسم حامل البطاقة'.tr,
                    ),
                  ),
                  SizedBox(height: Get.width * 0.05,),
                  const Divider(
                    color: Colors.green,
                    thickness: 1,
                  ),
                  SizedBox(height: Get.width * 0.05,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                        'القاصة : ${formatter.format(profileController.userList[0].summary.totalLoss)}'
                    ),
                      ],
                    ),
                  ),
                  const  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                            'عمولة التحويل : 500 د.ع',
                          style: TextStyle(
                            color: Colors.redAccent
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          ' الصافي : ${formatter.format(profileController.userList[0].summary.totalLoss - 500)}',
                          style: TextStyle(
                              color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.04
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            child: Text(
                                'إلغاء'.tr
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.05,),
                        GestureDetector(
                          onTap: () async {
                            if(profileController.payment_name.text.isNotEmpty && profileController.payment_number.text.isNotEmpty){
                              await profileController.addOrder();
                              if(profileController.isPay.value){
                                Get.back();
                                Get.snackbar('تم بنجاح', 'تم ارسال طلب استلام الاموال بنجاح');
                              }else{
                                Get.back();
                                Get.snackbar('خطآ', 'حدث خطآ معين');

                              }
                            }else{
                              Get.snackbar('خطآ', 'يرجى ادخال جميع معلومات البطاقة');
                            }


                          },
                          child: Container(
                            child: Text(
                                'ارسال'.tr
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }
  }


