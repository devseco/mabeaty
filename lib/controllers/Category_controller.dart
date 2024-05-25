import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabeaty/models/Category.dart';

import '../Services/RemoteServices.dart';

class Category_controller extends GetxController{
  var isLoadingCategories = true.obs;
  late TextEditingController myController = TextEditingController();
  var categoriesList = <CategoryModel>[].obs;
  void fetchCategories() async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchCategories();
      if(categories != null){
        categoriesList.value = categories;
      }else{
      }
    }finally{
      isLoadingCategories(false);
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchCategories();
    super.onInit();
  }
}