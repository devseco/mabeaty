import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mabeaty/controllers/Landing_controller.dart';
import 'package:mabeaty/models/CartModel.dart';
late Box BoxCart;
class Cart_controller extends GetxController {
  var isAddedCart = false.obs;
  var isLoadingAdded = false.obs;
  var msgAdded = '';
  var total = 0;
  var totalUser = 0;
  var isBlockAdded = false.obs;

  void PlusAllData() {
    totalUser = 0;
    total = 0;
    for(var i = 0 ; i< BoxCart.length; ++i) {
      var item = BoxCart.getAt(i);
      int priceUser = item.priceUser;
      int price = item.price;
      int count = item.count;
      totalUser += priceUser * count;
      total += price * count;
    }
    refreshCount();
    update();
  }
  void refreshCount() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Landing_controller landing_controller = Get.find();
      landing_controller.setCount();
    });
  }
  void updateCounterPlus(title , price , count,id,image, category , priceUser){
    var counter = count + 1;
    BoxCart.putAt(id, CartModel(price: price, title: title, count: counter, image: image, category: category, item: id,id: id , priceUser: priceUser));
    PlusAllData();
    update();
  }
  void updateCounterMin(title , price , count,id,image, category , priceUser){
    if(count > 1){
      var counter = count - 1;
      BoxCart.putAt(id, CartModel(price: price, title: title, count: counter, image: image, category: category, item: id,id: id , priceUser: priceUser));
      PlusAllData();
      update();
    }else{
    }
  }
  void is_existsloading(){
    isAddedCart(false);
    isLoadingAdded(true);
    update();
  }
  void is_Bloackloading(){
    isBlockAdded(true);
    isAddedCart(false);
    isLoadingAdded(true);
    update();
  }
  void is_loading(){
    msgAdded = 'Loading';
    isAddedCart(true);
    isLoadingAdded(true);
    update();
  }
  void is_loadingDone(){
    msgAdded = 'Done';
    isLoadingAdded(false);
    update();
  }

  void Plus(title , price , count,id,image, category , priceUser){
    var counter = count + 1;
    BoxCart.putAt(id, CartModel(price: price, title: title, count: counter, image: image, category: category, item: id,id: id , priceUser: priceUser));
    PlusAllData();
    update();
  }
  void putDate(title , price , count,id,image, category , priceUser)  {
    is_loading();
     try{
       var totalCount = 0;
       for(var i = 0 ; i< BoxCart.length; ++i) {
         var item = BoxCart.getAt(i);
         totalCount += item.count as int;
       }
       print('Total : ${totalCount}');
       if(totalCount != 3){
           if(!BoxCart.containsKey(id)){
             BoxCart.put(id, CartModel(price: price, title: title, count: count, image: image, category: category, item: id,id: id  , priceUser : priceUser)).whenComplete(() {
               is_loadingDone();
               Cart_controller cart_controller = Get.put(Cart_controller());
               cart_controller.PlusAllData();
               Get.offNamed('/landing');
               update();
             }).onError((error, stackTrace) {
               is_loadingDone();
               msgAdded = "Error";
               Get.offNamed('/landing');
               update();
             });
           }else{
             is_existsloading();
           }

       }else{
         is_Bloackloading();
         msgAdded = "Error";
       }

       isLoadingAdded(false);
       update();
     }catch(err){
       print(err);
     }
  }
  void deleteData(index) {
    BoxCart.deleteAt(index);
    PlusAllData();
    update();
  }
  void deleteAll(){
    BoxCart.clear();
    PlusAllData();
    update();
  }
  @override
  void onInit() {
    PlusAllData();
    print('rady');
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    PlusAllData();
    print('rady');
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    print('close');
    // TODO: implement onClose
    super.onClose();
  }


}