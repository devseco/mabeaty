import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:textfield_search/textfield_search.dart';
import '../controllers/Home_controller.dart';
import '../controllers/RecentlyProducts_controller.dart';
import '../main.dart';
import '../models/TestItem.dart';

class RecentlyProducts extends StatelessWidget {
  RecentlyProducts({super.key});
  final RecentlyProductsController controller = Get.put(RecentlyProductsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          '12'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Get.height * 0.018,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            spaceH(Get.height * 0.015),
            Row(
              children: [
                searchTextInput(),
                filtersIcon(),
              ],
            ),
            spaceH(Get.height * 0.015),
            GetBuilder<RecentlyProductsController>(builder: (builder) {
              if (!builder.isLoadingItem.value) {
                if (builder.productList.isNotEmpty) {
                  return Expanded(child: ItemsList());
                } else {
                  return Center(
                    child: Text('12'.tr),
                  );
                }
              } else {
                return loading_();
              }
            }),
          ],
        ),
      ),
    );
  }

  loading_() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 80,
      ),
    );
  }

  SizedBox spaceH(double size) {
    return SizedBox(
      height: size,
    );
  }

  SizedBox spaceW(double size) {
    return SizedBox(
      width: size,
    );
  }

  Padding filtersIcon (){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.009 , end: Get.height * 0.009),
      child:  GestureDetector(
        onTap: showDialog,
        child: const Icon(Icons.tune),
      ),
    );
  }

  Padding searchTextInput() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Get.height * 0.02,
        end: Get.height * 0.002,
      ),
      child: SizedBox(
        width: Get.width * 0.83,
        child: GetBuilder<RecentlyProductsController>(builder: (c){
          return TextFieldSearch(
            label: 'My Label',
            controller: c.myController,
            future: () {
              return c.fetchData();
            },
            getSelectedValue: (value) {
              TestItem selectedItem = value as TestItem; // تأكد من أن القيمة هي من نوع TestItem
              Get.toNamed('product' , arguments:[{"id": selectedItem.value}],);
              c.myController.clear();

            },

            decoration:  InputDecoration(
              fillColor: const Color(0xfff1ebf1),
              filled: true,
              prefixIcon: const Icon(Icons.search),
              hintText: '9'.tr,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide:  BorderSide(
                  color: Color(0xfff1ebf1),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color:Color(0xfff1ebf1),),
              ),
            ),

          );
        },),
      ),
    );
  }

  ItemsList() {
    return RefreshIndicator(
      onRefresh: () async{
        controller.fetchProducts(1, 10);
      },
      child: GridView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.only(
          right: Get.height * 0.009,
          left: Get.height * 0.009,
          bottom: Get.width * 0.6
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.productList.length + (controller.isLoadingItem.value ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index >= controller.productList.length) {
            // Show loading indicator at the bottom
            return Center(child: CircularProgressIndicator());
          } else {
            final product = controller.productList[index];
            return Item(
              product.image,
              product.title,
              product.price,
              product.id,
              product.lastprice,
              product.count,
              product.renewable,
            );
          }
        },
      ),
    );
  }

  Item(String url, String title, int price, int id, lastprice, int count, int renewable) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/product', arguments: [{'id': id}]);
      },
      child: Container(
        padding: EdgeInsets.all(Get.height * 0.017),
        width: Get.height * 0.2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CachedNetworkImage(
                height: Get.height * 0.12,
                width: Get.height * 0.18,
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            spaceH(Get.height * 0.01),
            Text(
              title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            spaceH(Get.height * 0.004),
            Text(
              formatter.format(price) + " د.ع ",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            spaceH(Get.height * 0.01),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المتوفر : ${count ~/ 2} - $count',
                  textAlign: TextAlign.start,
                  style:  TextStyle(
                    fontSize: Get.width * 0.025,
                    color: Colors.black45,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                spaceH(Get.height * 0.007),
                Text(
                  (renewable == 1) ? 'قابل للتجديد' : '',
                  textAlign: TextAlign.start,
                  style:  TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w400,
                    fontSize: Get.width * 0.025,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  showDialog(){
    return Get.dialog(
        barrierDismissible: false,
        Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Center(
                    child: Text("76".tr),
                  ),
                ),
                const SizedBox(height:10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GetBuilder<RecentlyProductsController>(builder: (c){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            c.changeSelected(1);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent , width: 0.5),
                                color: (c.selectedFilter == 1)? Colors.deepPurple : Colors.white
                            ),
                            child: Text(
                              'الاكثر توفرآ',
                              style: TextStyle(
                                  color: (c.selectedFilter == 1)? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        ),
                        spaceW(5),
                        GestureDetector(
                          onTap: (){
                            c.changeSelected(2);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: (c.selectedFilter == 2)? Colors.deepPurple : Colors.white,
                                border: Border.all(color: Colors.blueAccent , width: 0.5)
                            ),
                            child: Text(
                              'الاكثر مبيعآ',
                              style: TextStyle(
                                  color: (c.selectedFilter == 2)? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },),
                ),
                const Divider(
                  color: Colors.green,
                  thickness: 1,
                ),
                Padding(padding: const EdgeInsets.all(10),
                  child:  Row(
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          child: Text(
                              '53'.tr
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
