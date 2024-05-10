import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
  Widget settingUser(){
    return Container(
      margin: EdgeInsets.only(top: Get.width * 0.9 , right: Get.width * 0.04),
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
                Icon(Icons.shopping_cart_outlined , size: Get.width * 0.06,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'سلة المشتريات',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.05,
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
                Icon(Icons.info_outline , size: Get.width * 0.06,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'الدعم الفني',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.05,
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
                Icon(Icons.developer_mode , size: Get.width * 0.06,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'مطور التطبيق',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.05,
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
                Icon(Icons.logout , size: Get.width * 0.06,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'تسجيل خروج',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.05,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
  Widget statusOrders(){
    return Container(
      width: Get.width,
      height: Get.width * 0.28,
      margin: EdgeInsets.only(top: Get.width * 0.6),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      padding:
                       EdgeInsets.only(top: Get.width * 0.04, bottom: Get.width * 0.01 ),
                      child:  Text("المشتريات",
                          style:  TextStyle(
                              color: Colors.black ,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.bold

                          ))),
                  Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child:  Text('30 فاتورة' ,
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: Get.width * 0.035

                          ))),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      padding:
                      EdgeInsets.only(top: Get.width * 0.04, bottom: Get.width * 0.004 ),
                      child:  Text("المبلغ الكلي",
                          style:  TextStyle(
                              color: Colors.black54,
                              fontSize: Get.width * 0.04,
                              fontWeight: FontWeight.bold

                          ))),
                  Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child:  Text('300,250 ${'18'.tr}',
                          style:  TextStyle(
                              color: Colors.deepPurple,
                              fontSize: Get.width * 0.035
                          ))),
                ],
              ),

            ],
          ),
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
              '07712710192',
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
              'Devseco@gmail.com',
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
              'بغداد - البنوك',
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
          'علي محمد',
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
          Icon(Icons.check_circle , color: Colors.green,),
          SizedBox(width: Get.width * 0.01,),
          Text(
              'موثق',
            style: TextStyle(
              color:Colors.green,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}
