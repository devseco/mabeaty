import 'package:get/get.dart';
import 'package:ui_ecommerce/models/Product.dart';
import '../Services/RemoteServices.dart';

class Product_controller extends GetxController {
  var isLoadingItem= false.obs;
  var productList = <Product>[].obs;
  int index = 0;
  var rate  = 3.0;
  int count = 1;
  dynamic argumentData = Get.arguments;

  final List<String> imgList = [
    'https://image.cnbcfm.com/api/v1/image/106742568-1602615652022-gettyimages-1229049972-APPLE-IPHONES.jpg?v=1602615662&w=1600&h=900',
    'https://anakle.com/wp-content/uploads/2023/06/apple.jpg'
  ];

  void fetchProduct(id) async{
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductone(id);
      if(products != null){
        productList.value = products;
        isLoadingItem(false);
      }else{
        isLoadingItem(false);
      }
    }finally{
      isLoadingItem(false);
    }
    update();
  }


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
  @override
  void onInit() {
    fetchProduct(argumentData[0]['id']);
    // TODO: implement onInit
    super.onInit();
  }
}