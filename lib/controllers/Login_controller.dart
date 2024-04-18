import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Login_controller extends GetxController{
  //variable for check Remember me
  late bool isremember = false;
  late TextEditingController phone_controller  = TextEditingController();
  late TextEditingController password_controller = TextEditingController();
  //void for check Remember me
  void is_checking() {
    if(isremember){
      isremember = false;
    }else{
      isremember = true;
    }
    update();
   }



}