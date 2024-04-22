import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String title;
  int price;
  String description;
  String image;
  String rate;
  int category;
  int lastprice;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rate,
    required this.category,
    required this.lastprice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    rate: json["rate"],
    category: json["category"],
    lastprice: json["lastprice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "image": image,
    "rate": rate,
    "category": category,
    "lastprice": lastprice,
  };
}
