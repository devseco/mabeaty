import 'package:get/get.dart';
import 'package:mabeaty/Services/RemoteServices.dart';
import 'package:mabeaty/controllers/Billing_controller.dart';
import 'package:mabeaty/controllers/Cart_controller.dart';
import 'package:mabeaty/controllers/Delivery_controller.dart';
import 'package:mabeaty/main.dart';
class Checkout_controller extends GetxController{
  var isPay = false.obs;
  int price  = 0;
  int delivery_Baghdad = 4000;
  int delivery_another = 6000;
  int delivery = 0;
  int profit = 0;
  int currentStep = 0;
  var user_id;
  int total_user = 0;
  int total = 0;
  int fullTotal = 0;
  var name_agent ;

  @override
  void onInit() {
    price = Get.arguments[0]['total'];
    total_user = Get.arguments[0]['totalUser'];
    profit = total_user - price;
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
  Future<bool> addBill(phone,city,address,price,delivery,items,customer_name,customer_total,customer_nearpoint , profit , note) async{
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
        'price_user': cartItem.priceUser
      };
      list.add(mappedItem);
    }
    var result = await RemoteServices.addBill(name_agent, phone, city, address, price, delivery, list , user_id ,customer_name , customer_total , customer_nearpoint , profit , note );
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