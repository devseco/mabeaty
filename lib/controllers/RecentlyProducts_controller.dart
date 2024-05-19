import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Services/RemoteServices.dart';
import '../models/Product.dart';
import '../models/TestItem.dart';

class RecentlyProductsController extends GetxController {
  var isLoadingItem = false.obs;
  var productList = <Product>[].obs;
  var page = 1.obs; // تبدأ الصفحة من 1
  int selectedFilter = 0;
  TextEditingController myController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void changeSelected(selected){
    selectedFilter = selected;
    fetchFilter(page.value,10);
    update();
  }

  void fetchFilter(int page, int limit) async {
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductsRecently(page, limit);
      if (products != null) {
        if (page == 1) {
          productList.value = products;
        } else {
          productList.addAll(products);
        }
        isLoadingItem(false);
      }
    } catch (e) {
      isLoadingItem(false);
    } finally {
      isLoadingItem(false);
    }
    update();
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
  @override
  void onInit() {
    super.onInit();
    myController.addListener(_printLatestValue);
    fetchProducts(page.value, 10); // تحميل الصفحة الأولى
    scrollController.addListener(_scrollListener);
  }
  _printLatestValue() {
    print("Textfield value: ${myController.text}");
    //print("Textfield value: ${myController.text}");
  }
  void fetchProducts(int page, int limit) async {
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductsRecently(page, limit);
      if (products != null) {
        if (page == 1) {
          productList.value = products;
        } else {
          productList.addAll(products);
        }
        isLoadingItem(false);
      }
    } catch (e) {
      isLoadingItem(false);
    } finally {
      isLoadingItem(false);
    }
    update();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadingItem.value) {
      isLoadingItem(true);
      var newPage = page.value + 1;
      fetchProducts(newPage, 10);
      page.value = newPage;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }
}
