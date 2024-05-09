import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_ecommerce/controllers/Checkout_controller.dart';

import '../main.dart';

class Delivery_controller extends GetxController{
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
  List<String> gonvernorates = [];
  String? selectedGovernorate ;
  late TextEditingController name  = TextEditingController();
  late TextEditingController address  = TextEditingController();
  late TextEditingController phone  = TextEditingController();
  late TextEditingController price  = TextEditingController();
  late TextEditingController nearPoint  = TextEditingController();
 void changeSelect(value){
   selectedGovernorate = value;
   final Checkout_controller checkout_controller = Get.put(Checkout_controller());
   if(selectedGovernorate == 'بغداد'){
     checkout_controller.delivery = checkout_controller.delivery_Baghdad;
   }else{
     checkout_controller.delivery = checkout_controller.delivery_another;
   }
   update();
 }
 void FormatNumber(value){
   String newText = value.replaceAll(RegExp(r'[^0-9]'), '');

   // Add commas for every three digits from the right
   newText = NumberFormat("#,###").format(int.parse(newText));

   // Set the formatted value back to the TextField
   this.price.value = TextEditingValue(
     text: newText,
     selection: TextSelection.collapsed(offset: newText.length),
   );
 }
 @override
  void onInit() {

   var sharePhone = sharedPreferences!.getInt('phone')!;
   print('${sharePhone} is phone');
   gonvernorates = sharedPreferences!.getString('lang') == 'ar' ? governorates_ar : governorates_ar;
   //phone.text = ;
    // TODO: implement onInit
    super.onInit();
  }


}