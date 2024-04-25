import 'package:get/get.dart';

class Checkout_controller extends GetxController{
  int total = 0;
  int price = Get.arguments[0]['total'] ?? 0;
  int delivery = 5000;
  int currentStep = 0;
  @override
  void onInit() {
    total = price + delivery;
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

  void CancelStap(){
    if (currentStep > 0) {
      currentStep -= 1;
    } else {
      currentStep = 0;
    }
    update();
  }

}