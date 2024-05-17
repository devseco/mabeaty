import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/controllers/ProfileController.dart';
import 'package:ui_ecommerce/main.dart';
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
      margin: EdgeInsets.only(top: Get.width * 0.95 , right: Get.width * 0.05 ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.width * 0.10,
            ),
            Row(
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
            SizedBox(
              height: Get.width * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shopping_cart_outlined , size: Get.width * 0.04,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'سلة المشتريات',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.width * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline , size: Get.width * 0.04,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'الدعم الفني',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.width * 0.06,
            ),
            GestureDetector(
              onTap: (){
                //controller.logout();

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

          ],
        ),
      ),
    );
  }
  Widget statusOrders(){
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
                          child:  Text('${formatter.format(profileController.userList[0].summary.totalLoss)} د.ع '  ,
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
                          child:  Text('${formatter.format(profileController.userList[0].summary.totalExpectedProfit)} د.ع '  ,
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
                          child:  Text('${formatter.format(profileController.userList[0].summary.totalReturnedOrders)} د.ع '  ,
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
                          child:  Text('${formatter.format(profileController.userList[0].summary.totalReceivedProfit)} ${'18'.tr}',
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
            Icon(Icons.email , size: Get.width * 0.04,),
            SizedBox(width: Get.width * 0.015,),
            Text(
              '${profileController.userList[0].userInfo.email}',
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
}
