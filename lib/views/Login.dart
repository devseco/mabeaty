import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Login_controller.dart';
class Login extends StatelessWidget {
  Login({super.key});
  final Login_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(



      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _logo(),
          _space(Get.height * 0.03),
          _text("2" , Get.height * 0.03,Colors.black,FontWeight.w600),
          _space(Get.height * 0.01),
          _text("6" , Get.height * 0.015,Colors.black,FontWeight.w400),
          _space(Get.height * 0.035),
          _textme('3' , controller.phone_controller , false),
          _space(Get.height * 0.02),
          _textme('4' , controller.password_controller , true),
          _remberMeCheckBox(),
          _space(Get.height * 0.01),
          _text('13', Get.height * 0.016, Colors.black, FontWeight.w600),
          _space(Get.height * 0.02),
          _buttonLogin(),
          _space(Get.height * 0.02),
          _text('8', Get.height * 0.013, Colors.black, FontWeight.w300),
          _space(Get.height * 0.03),
          _text('5', Get.height * 0.016, Colors.black, FontWeight.w600),
        ],
      ),

    );

  }
  _logo(){
    return Center(
      child: Image.asset("assets/images/logo.png",
        height: Get.height / 7,
      ),
    );
  }
  _text(String title , double size , Color color , FontWeight fontWeight){
    return Center(
      child: Text(title.tr,
        style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color : color
        ),
      ),
    );
  }

  SizedBox _space(double size){
    return SizedBox(
      height: size,
    );
  }

  Padding _textme(String title , TextEditingController textEditingController , bool ispassword){
    return Padding(padding: EdgeInsets.only(right: Get.width * 0.1 , left: Get.width * 0.1),
      child:   TextField(
        obscureText: ispassword,
        controller: textEditingController,
        decoration:   InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          hintText: title.tr,
        ),
      ),
    );
  }

  _buttonLogin(){
    return Center(
      child: Padding(padding: EdgeInsets.only(right: Get.height * 0.04 , left: Get.height * 0.04),
        child: GestureDetector(
          onTap: (){
            Get.offAllNamed('landing');
          },
          child: Container(
            width: Get.height * 0.30,
            height: Get.height * 0.055,
            color: Colors.black,
            child: Center(
              child: Text(
                "1".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Get.height * 0.02
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _remberMeCheckBox() {
    return GetBuilder<Login_controller>(builder: (controller){
      return CheckboxListTile(
        checkColor: Colors.white,
        activeColor: Colors.grey,
        value: controller.isremember,
        onChanged: (value) {
         controller.is_checking();
        },
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsetsDirectional.only(start: Get.height * 0.035),
        title: Text(
          '7'.tr,
          style: const TextStyle(color: Colors.black, fontFamily: "Dubai", fontSize: 14),
        ),
      );
    });
  }
}
