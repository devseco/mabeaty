import 'package:get/get.dart';
import 'package:ui_ecommerce/Services/RemoteServices.dart';
import 'package:ui_ecommerce/controllers/Billing_controller.dart';
import 'package:ui_ecommerce/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/controllers/Delivery_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Checkout_controller extends GetxController{
  var isPay = false.obs;
  int price  = 0;
  int delivery_Baghdad = 4000;
  int delivery_another = 6000;
  int delivery = 0;
  int currentStep = 0;
  var user_id ;
  int total_user = 0;
  var name_agent ;
  void setTotal(value){
    total_user = value;
    update();
  }
  @override
  void onInit() {
    price = Get.arguments[0]['total'];
    user_id = sharedPreferences?.getInt('user_id');
    name_agent = sharedPreferences!.getString('name')!;
    update();
    // TODO: implement onInit
    super.onInit();
  }
  void ContinueStap(){
    if (currentStep < 2) {
      currentStep += 1;
    } else {
      // Handle last step actions (e.g., submitting)
      // You can add your logic here
    }
    update();
  }
  Future<bool> addBill(phone,city,address,price,delivery,items,customer_name,customer_total,customer_nearpoint) async{
    var list = <Map<String, dynamic>>[];
    for (int x = 0; x < BoxCart.length; x++) {
      var cartItem = BoxCart.getAt(x);
      // Convert cartItem to Map<String, dynamic> if needed
      var mappedItem = {
        'title': cartItem.title,
        'image': cartItem.image,
        'count': cartItem.count,
        'id':    cartItem.id,
        'price': cartItem.price,
      };
      list.add(mappedItem);
    }
    var result = await RemoteServices.addBill(name_agent, phone, city, address, price, delivery, list , user_id ,customer_name , customer_total , customer_nearpoint );
      if(result.contains('successfully')){
        isPay(true);
        Cart_controller c = Get.put(Cart_controller());
        Billing_controller cBilling  = Get.put(Billing_controller());
        cBilling.fetchBills();
        c.deleteAll();
        c.PlusAllData();
        update();
        return true;
      }else{
        return false;
      }
  }

  void CancelStap(){
    if (currentStep > 0) {
      currentStep -= 1;
    } else {
      currentStep = 0;
    }
    update();
  }

}