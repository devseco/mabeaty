import 'package:get/get.dart';
import 'package:mabeaty/models/Category.dart';
import '../Services/RemoteServices.dart';
class Category_controller extends GetxController{
  var isLoadingCategories = false.obs;
  var categoriesList = <CategoryModel>[].obs;
  void fetchCategories() async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchCategories();
      if(categories != null){
        categoriesList.value = categories;
        isLoadingCategories(false);
      }else{
        isLoadingCategories(false);
      }
    }finally{
      isLoadingCategories(false);
    }
    isLoadingCategories(false);
    update();
  }
  @override
  void onInit() {
    fetchCategories();
    // TODO: implement onInit
    super.onInit();
  }
}