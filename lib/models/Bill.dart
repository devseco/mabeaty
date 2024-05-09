import 'dart:convert';
List<Bill> billFromJson(String str) => List<Bill>.from(json.decode(str).map((x) => Bill.fromJson(x)));
String billToJson(List<Bill> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bill {
  int id;
  String name;
  String phone;
  String city;
  String address;
  int status;
  DateTime date;
  int price;
  int delivery;
  int userId;
  String customerName;
  int customerTotal;
  String customerNearpoint;

  Bill({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.address,
    required this.status,
    required this.date,
    required this.price,
    required this.delivery,
    required this.userId,
    required this.customerName,
    required this.customerTotal,
    required this.customerNearpoint,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    city: json["city"],
    address: json["address"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
    price: json["price"],
    delivery: json["delivery"],
    userId: json["user_id"],
    customerName: json["customer_name"],
    customerTotal: json["customer_total"],
    customerNearpoint: json["customer_nearpoint"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "city": city,
    "address": address,
    "status": status,
    "date": date.toIso8601String(),
    "price": price,
    "delivery": delivery,
    "user_id": userId,
    "customer_name": customerName,
    "customer_total": customerTotal,
    "customer_nearpoint": customerNearpoint,
  };
}
