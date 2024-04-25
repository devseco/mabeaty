import 'package:get/get.dart';
import '../Services/RemoteServices.dart';
import '../models/Product.dart';
class Products_Controller extends GetxController {
  dynamic argumentData = Get.arguments;
  var isLoadingItem= false.obs;
  var productList = <Product>[].obs;
  void fetchProduct(id) async{
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductByCate(id);
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
  @override
  void onInit() {
    fetchProduct(argumentData[0]['id']);
    // TODO: implement onInit
    super.onInit();
  }
}