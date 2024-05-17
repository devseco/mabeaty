import 'package:get/get.dart';
import 'package:ui_ecommerce/models/UserInfo.dart';

import '../Services/RemoteServices.dart';
import '../main.dart';

class ProfileController extends GetxController{
  var isLoadingUser = true.obs;
  var userList = <UserInfo>[].obs;
  void fetchProfile() async{
    var user_id = sharedPreferences!.getInt('user_id');
    isLoadingUser(true);
    try {
      var profile = await RemoteServices.fetchProfile(user_id);
      if(profile != null){
        userList.value = [profile]; // تحويل الكائن إلى قائمة تحتوي على عنصر واحد
      }
    }finally{
      isLoadingUser(false);
    }
    update();
  }
  @override
  void onInit() {
    fetchProfile();
    // TODO: implement onInit
    super.onInit();
  }



}