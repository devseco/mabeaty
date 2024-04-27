import 'package:get/get.dart';
import 'package:ui_ecommerce/main.dart';
import 'package:ui_ecommerce/models/Bill.dart';
import '../Services/RemoteServices.dart';

class Billing_controller extends GetxController{
  var isLoadingBills= true.obs;
  var billsList = <Bill>[].obs;
  void fetchBills() async{
    var user_id = sharedPreferences!.getInt('user_id');
    isLoadingBills(true);
    try {
      var products = await RemoteServices.fetchBills(user_id);
      if(products != null){
        billsList.value = products;
      }else{
      }
    }finally{
      isLoadingBills(false);
    }
    update();
  }
  @override
  void onInit() {
    fetchBills();
    // TODO: implement onInit
    super.onInit();
  }
}