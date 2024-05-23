// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int id;
  String title;
  int price;
  String description;
  String image;
  int category;
  int lastprice;
  int count;
  int renewable;
  List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.lastprice,
    required this.count,
    required this.renewable,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    category: json["category"],
    lastprice: json["lastprice"],
    count: json["count"],
    renewable: json["renewable"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "image": image,
    "category": category,
    "lastprice": lastprice,
    "count": count,
    "renewable": renewable,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
