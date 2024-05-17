import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/Services/RemoteServices.dart';
import 'package:ui_ecommerce/models/Category.dart';
import 'package:ui_ecommerce/models/TestItem.dart';
import '../models/Product.dart';
import '../models/Slider.dart';
class Home_controller extends GetxController {
  int index = 0;
  var isLoadingProductes= true.obs;
  var isLoadingSliders= true.obs;
   List<String> productNames = [];
  var isLoadingCategories= true.obs;
  var productsList = <Product>[].obs;
  var slidersList = <SliderBar>[].obs;
  var filterProducts = <TestItem>[].obs;
  var categoriesList = <CategoryModel>[].obs;
  TextEditingController myController = TextEditingController();

  //fetch Productes
  void fetchProducts(page , limit) async{
    isLoadingProductes(true);
    try {
      var products = await RemoteServices.fetchProductsRecently(page , limit);
      if(products != null){
        productsList.value = products;
      }else{
      }
    }finally{
      isLoadingProductes(false);
    }
    update();
  }
  //fetch Sliders
  void fetchSliders() async{
    isLoadingSliders(true);
    try {
      var sliders = await RemoteServices.fetchSliders();

      if(sliders != null){
        isLoadingSliders(true);
        slidersList.value = sliders;
      }
    }finally{
      isLoadingSliders(false);
    }
  }
  //fetch Categories
  void fetchCategories() async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchCategories();
      if(categories != null){
        isLoadingCategories(true);
        categoriesList.value = categories;
        print(isLoadingSliders);
      }
    }finally{
      isLoadingCategories(false);
    }
  }


  Future<List<TestItem>> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    List<TestItem> _list = [];
    String _inputText = myController.text;
    List<dynamic> filters = await RemoteServices.filterProducts(_inputText);
    // تحويل كل عنصر في القائمة filters إلى كائن TestItem
    for (var jsonItem in filters) {
      _list.add(TestItem.fromJson(jsonItem));
    }
    return _list;
  }




  _printLatestValue() {
    print("Textfield value: ${myController.text}");
    //print("Textfield value: ${myController.text}");
  }
  @override
  void onInit() {
    // TODO: implement onInit
    myController.addListener(_printLatestValue);
    fetchProducts(1,10);
    fetchCategories();
    fetchSliders();
    super.onInit();
  }
  void changeindex(int i){
    index = i;
    update();
  }



}