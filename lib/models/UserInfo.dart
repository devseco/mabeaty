// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfoClass userInfo;
  Summary summary;

  UserInfo({
    required this.userInfo,
    required this.summary,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userInfo: UserInfoClass.fromJson(json["userInfo"]),
    summary: Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "userInfo": userInfo.toJson(),
    "summary": summary.toJson(),
  };
}

class Summary {
  int totalLoss;
  int totalReceivedProfit;
  int totalReturnedOrders;
  int totalExpectedProfit;

  Summary({
    required this.totalLoss,
    required this.totalReceivedProfit,
    required this.totalReturnedOrders,
    required this.totalExpectedProfit,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalLoss: json["total_loss"],
    totalReceivedProfit: json["total_received_profit"],
    totalReturnedOrders: json["total_returned_orders"],
    totalExpectedProfit: json["total_expected_profit"],
  );

  Map<String, dynamic> toJson() => {
    "total_loss": totalLoss,
    "total_received_profit": totalReceivedProfit,
    "total_returned_orders": totalReturnedOrders,
    "total_expected_profit": totalExpectedProfit,
  };
}

class UserInfoClass {
  String name;
  String phone;
  String email;
  String city;
  String address;
  int active;

  UserInfoClass({
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
    required this.address,
    required this.active,
  });

  factory UserInfoClass.fromJson(Map<String, dynamic> json) => UserInfoClass(
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    city: json["city"],
    address: json["address"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "city": city,
    "address": address,
    "active": active,
  };
}
