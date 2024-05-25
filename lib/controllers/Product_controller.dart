import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mabeaty/models/Product.dart';
import 'package:mabeaty/models/ProductsModel.dart';
import '../Services/RemoteServices.dart';

class Product_controller extends GetxController {
  var isLoadingItem= false.obs;
  var productList = <Product>[].obs;
  var productItemList = <ProductModel>[].obs;
  int index = 0;
  var rate  = 3.0;
  int count = 1;
  int id = 0;
  int lowerPrice = 0;
  int lowerPriceLabel = 0;
  TextEditingController priceUser = TextEditingController();
  dynamic argumentData = Get.arguments;

  void FormatNumber(value){
    String newText = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Add commas for every three digits from the right
    newText = NumberFormat("#,###").format(int.parse(newText));

    // Set the formatted value back to the TextField
    this.priceUser.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  void Calculate(int price){
    if (price >= 1000 && price <= 5000) {
      lowerPrice = price + 2000;
    } else if (price >= 6000 && price <= 20000) {
      lowerPrice = price + 3000;
    } else if (price >= 21000 && price <= 50000) {
      lowerPrice = price + 5000;
    } else if (price >= 51000 && price <= 100000) {
      lowerPrice = price + 10000;
    } else {
      lowerPrice = price + 15000;
    }
    lowerPriceLabel = lowerPrice;

    update();
  }
  void fetchProduct() async{
    isLoadingItem(true);
    try {
      var product = await RemoteServices.fetchProductone(id);
      if(product != null){
        productItemList.value = [product];
        Calculate(product.price);
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
  void inCounter(count_now){
    if(count < 3){
      if(count_now > 1){
        count++;
        lowerPriceLabel = lowerPrice * count;
      }
    }
    update();
  }


  void outCounter(){
    if(count != 1)
    count --;
    lowerPriceLabel = lowerPrice * count;
    update();
  }
  void saveNetworkImage(String url) async {
    final imagePath = '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}}.jpg';
    await Dio().download('$url',imagePath);
    await Gal.putImage(imagePath);
    Get.snackbar('حفظ الصورة', 'تم حفظ الصورة بنجاح');

  }

  @override
  void onInit() {
    id = argumentData[0]['id'];
    fetchProduct();
    // TODO: implement onInit
    super.onInit();
  }
}