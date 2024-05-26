import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Bindings/Landing_bindings.dart';
import '../Services/RemoteServices.dart';
import '../main.dart';
import '../views/Landing.dart';

class RegisterController extends GetxController{
  late bool loading = false;
  late bool errorRegister= false;
  late String errormsg = '';
  late TextEditingController phone_  = TextEditingController();
  late TextEditingController password_ = TextEditingController();
  late TextEditingController name_ = TextEditingController();
  late TextEditingController address_  = TextEditingController();
  late TextEditingController pageName_  = TextEditingController();
  List<String> governorates_en = [
    'Baghdad',
    'Basra',
    'Dhi Qar',
    'Wasit',
    'Maysan',
    'Muthanna',
    'Karbala',
    'Najaf',
    'Qadisiyah',
    'Babil',
    'Diyala',
    'Salah ad-Din',
    'Kirkuk',
    'Nineveh',
    'Erbil',
    'Dohuk',
    'Sulaymaniyah',
    'Al-Anbar',
  ];
  List<String> governorates_ar = [
    'بغداد',
    'البصرة',
    'ذي قار',
    'واسط',
    'ميسان',
    'المثنى',
    'كربلاء',
    'النجف',
    'القادسية',
    'بابل',
    'ديالى',
    'صلاح الدين',
    'كركوك',
    'نينوى',
    'اربيل',
    'دهوك',
    'السليمانية',
    'الانبار',
  ];
  void is_loading(){
    loading = true;
    update();
  }
  List<String> gonvernorates = [];
  String? selectedGovernorate ;
  void changeSelect(value){
    selectedGovernorate = value;
    update();
  }
  void isnot_loading(){
    loading = false;
    update();
  }
  void is_error(){
    errorRegister = true;
    update();
  }
  void register() async{
    if(phone_.text.isNotEmpty && name_.text.isNotEmpty && password_.text.isNotEmpty && address_.text.isNotEmpty && selectedGovernorate!.isNotEmpty  && pageName_.text.isNotEmpty){
      is_loading();
      var response = await RemoteServices.register(phone_.text.trim(), name_.text.trim(), password_.text.trim(), selectedGovernorate!, address_.text.trim() , pageName_.text.trim());
      if(response != null){
        var json_response = jsonDecode(response);
        print(json_response);
        if(json_response['message'] == "Successfully"){
          isnot_loading();
          Get.offNamed('/');
        }else if(json_response['message'] == "Phone number already in use"){
          errormsg = "95";
          is_error();
          print(json_response['message']);
          isnot_loading();
        }else{
          errormsg = json_response['message'];
          is_error();
          print(json_response['message']);
          isnot_loading();
        }
      }else{
        errormsg = "25";
        is_error();
        isnot_loading();
      }
    }else{
      errormsg = "94";
      is_error();
      isnot_loading();
    }

  }







  @override
  void onInit() {
    gonvernorates = sharedPreferences!.getString('lang') == 'ar' ? governorates_ar : governorates_ar;
    // TODO: implement onInit
    super.onInit();
  }





}