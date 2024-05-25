import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mabeaty/models/UserInfo.dart';
import '../Services/RemoteServices.dart';
import '../main.dart';
import '../views/Login.dart';
import 'Cart_controller.dart';
class ProfileController extends GetxController{
  var isLoadingUser = true.obs;
  var isPay = false.obs;
  var userList = <UserInfo>[].obs;
  late TextEditingController payment_number = TextEditingController();
  late TextEditingController payment_name = TextEditingController();
  var selectedPaymentMethod = 'زين كاش'.obs;
  List<String> paymentMethods = ['زين كاش', 'الرافدين (Qi)', 'اسيا حوالة' , 'فاست بي' , 'مصرف الطيف' , 'جيزلاني'];
  void fetchProfile() async{
    var user_id = sharedPreferences!.getInt('user_id');
    isLoadingUser(true);
    try {
      var profile = await RemoteServices.fetchProfile(user_id);
      if(profile != null){
        userList.value = [profile];
      }
    }finally{
      isLoadingUser(false);
    }
    update();
  }
  void deleteAccount() async{
    var name = sharedPreferences!.getString('name');
    var user_id = sharedPreferences!.getInt('user_id');
    await RemoteServices.deleteAccount(name , user_id);

   sharedPreferences!.clear();
    BoxCart.clear();
    Get.off(() => Login());
  }
  void logout(){
    sharedPreferences!.clear();
    //BoxCart.clear();
    Get.off(() => Login());
  }
  Future<bool> addOrder() async{
    var name = sharedPreferences!.getString('name');
    var phone = sharedPreferences!.getString('phone');
    var total = userList[0].summary.totalLoss;
   try{
     var result = await RemoteServices.addOrder(name, phone, total,selectedPaymentMethod.value,payment_number.text,payment_name.text);
     print(result);
     if(result.isNotEmpty){
       isPay(true);
       fetchProfile();
       print('added ok');
       update();
       return true;
     }else{
       return false;
     }
   }catch(e){
     print(e);
     return false;
   }
  }
  @override
  void onInit() {
    fetchProfile();
    // TODO: implement onInit
    super.onInit();
  }



}