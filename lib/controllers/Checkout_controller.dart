import 'package:get/get.dart';

class Checkout_controller extends GetxController{
  int currentStep = 0;
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