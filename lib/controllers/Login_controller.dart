import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/Services/RemoteServices.dart';
import 'package:ui_ecommerce/main.dart';
import 'package:ui_ecommerce/views/Landing.dart';
class Login_controller extends GetxController{

  //variable for check Remember me
  late bool isremember = false;
  late bool loading = false;
  late bool errorlogin = false;
  late String errormsg = '';
  late TextEditingController phone_  = TextEditingController();
  late TextEditingController password_ = TextEditingController();
  //void for check Remember me
  void is_checking() {
    if(isremember){
      isremember = false;
    }else{
      isremember = true;
    }
    update();
   }
   void is_loading(){
    loading = true;
    update();
   }
  void isnot_loading(){
    loading = false;
    update();
  }
  void is_error(){
    errorlogin = true;
    update();
  }
   void Login() async{
     is_loading();
    var response = await RemoteServices.login(phone_.text);
    if(response != null){
      var json_response = jsonDecode(response);
      if(json_response['message'] == "Login Successfully"){
        await sharedPreferences!.setString('token', json_response['access_token']);
        await sharedPreferences!.setInt('phone', json_response['phone']);
        await sharedPreferences!.setInt('user_id', json_response['user_id']);
        await sharedPreferences!.setString('name', json_response['username']);
        if(isremember){
          await sharedPreferences!.setBool('remember', true);
        }
        isnot_loading();
        Get.off(() => Landing() , binding: Landing_bindings());
      }else if(json_response['message'] == "No user found"){
        errormsg = "24";
        is_error();
        print(json_response['message']);
        isnot_loading();
      }else{
        errormsg = "25";
        is_error();
        print(json_response['message']);
        isnot_loading();
      }
    }else{
      errormsg = "25";
      is_error();
      isnot_loading();
    }

   }
}