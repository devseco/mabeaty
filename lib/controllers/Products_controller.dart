import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Services/RemoteServices.dart';
import '../models/Product.dart';
class Products_Controller extends GetxController {
  dynamic argumentData = Get.arguments;
  var isLoadingItem= false.obs;
  TextEditingController searchQueryController = TextEditingController();
  var productList = <Product>[].obs;
  void filterProductList(String query) {
    if (query.isEmpty) {
      // If the search query is empty, display all products
      fetchProduct(argumentData[0]['id']);
    } else {
      // Filter the productList based on the query
      var filteredList = productList.where((product) {
        // Replace 'product.title' with the field you want to search by
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      productList.value = filteredList;
    }
    update(); // Update the UI
  }
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