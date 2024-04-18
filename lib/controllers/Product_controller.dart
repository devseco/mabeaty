
import 'package:get/get.dart';

class Product_controller extends GetxController {
  int index = 0;
  var rate  = 3.0;
  int count = 1;
  final List<String> imgList = [
    'https://image.cnbcfm.com/api/v1/image/106742568-1602615652022-gettyimages-1229049972-APPLE-IPHONES.jpg?v=1602615662&w=1600&h=900',
    'https://anakle.com/wp-content/uploads/2023/06/apple.jpg'
  ];
  void changeindex(int i){
    index = i;
    update();
  }
  void inCounter(){
    count++;
    update();
  }
  void outCounter(){
    if(count != 1)
    count --;
    update();
  }
  void changeRate(double i){
    rate = i;
    update();
  }
}