import 'package:get/get.dart';

class Landing_controller extends GetxController{
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    print(index);
    update();
  }
}