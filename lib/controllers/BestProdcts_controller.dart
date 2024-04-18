import 'package:get/get.dart';

import '../models/Product.dart';

class BestProducts_controller extends GetxController{
  final List<Product> productList = [
    Product(
        id: 1,
        title: "Example Product",
        price: 100,
        description: "This is an example product description.",
        image: "https://i5.walmartimages.com/seo/Xbox-Series-X-Video-Game-Console-Black_9f8c06f5-7953-426d-9b68-ab914839cef4.5f15be430800ce4d7c3bb5694d4ab798.jpeg",
        rate: "4.5",
        category: 1,
        lastprice: 90),
    // Add more products here
  ];
}