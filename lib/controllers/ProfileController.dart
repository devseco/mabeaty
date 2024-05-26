import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mabeaty/models/UserInfo.dart';
import '../Services/RemoteServices.dart';
import '../main.dart';
import '../views/Login.dart';
import 'Cart_controller.dart';

class ProfileController extends GetxController {
  var isLoadingUser = true.obs;
  var isPay = false.obs;
  var total_now = 0;
  var total_inWay = 0;
  var total_back = 0;
  var total_all = 0;

  var userList = <UserInfo>[].obs;
  late TextEditingController payment_number = TextEditingController();
  late TextEditingController payment_name = TextEditingController();
  var selectedPaymentMethod = 'زين كاش'.obs;
  List<String> paymentMethods = [
    'زين كاش', 'الرافدين (Qi)', 'اسيا حوالة', 'فاست بي', 'مصرف الطيف', 'جيزلاني'
  ];

  void fetchProfile() async {
    userList.value.clear();
    var user_id = sharedPreferences!.getInt('user_id');
    isLoadingUser(true);
    try {
      var profile = await RemoteServices.fetchProfile(user_id);
      if (profile != null) {
        userList.value = [profile];
        carculat();
      }
    } finally {
      isLoadingUser(false);
    }

    update();
  }
  void carculat(){
    total_all = userList[0].summary.totalReceivedProfit;
    total_back = userList[0].summary.totalReturnedOrders;
    total_inWay = userList[0].summary.totalExpectedProfit;
    total_now = userList[0].summary.totalLoss;
    print('${userList[0].summary.totalLoss.toString()}');
    update();
  }

  void logout() {
    sharedPreferences!.clear();
    //BoxCart.clear();
    Get.offNamed('/');
  }

  Future<bool> addOrder() async {
    var name = sharedPreferences!.getString('name');
    var phone = sharedPreferences!.getString('phone');
    var total = userList[0].summary.totalLoss;
    try {
      var result = await RemoteServices.addOrder(name, phone, total, selectedPaymentMethod.value, payment_number.text, payment_name.text);
      print(result);
      if (result.isNotEmpty) {
        isPay(true);
        fetchProfile();
        print('added ok');
        return true;
      } else {
        fetchProfile();
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    payment_number.dispose();
    payment_name.dispose();
    super.dispose();
  }

  void deleteAccount() async {
    var name = sharedPreferences!.getString('name');
    var user_id = sharedPreferences!.getInt('user_id');
    await RemoteServices.deleteAccount(name, user_id);
    sharedPreferences!.clear();
    BoxCart.clear();
    Get.off(() => Login());
  }

  @override
  void onReady() {
    fetchProfile();
    super.onReady();
  }

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }
}
