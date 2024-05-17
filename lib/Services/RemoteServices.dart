import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui_ecommerce/models/Bill.dart';
import 'package:ui_ecommerce/models/Category.dart';
import 'package:ui_ecommerce/models/Product.dart';
import 'package:ui_ecommerce/models/Sale.dart';
import 'package:ui_ecommerce/models/TestItem.dart';
import 'package:ui_ecommerce/models/UserInfo.dart';
import '../models/Slider.dart';

class RemoteServices {
  static var client = http.Client();
  static var baseUrl = 'http://127.0.0.1:3000/';
//Login
  static Future login(phone) async {
    var endpoint = 'login';
    var body = jsonEncode({'phone': phone});
    try {
      var response = await client.post(Uri.parse(baseUrl + endpoint),
        body:body,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonData;
      } else {
        String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }
  //Fetch Profile From Endpoint (userInfo)
  static Future<UserInfo?> fetchProfile(id) async {
    var endpoint = 'userInfo/2';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        UserInfo userinfo = userInfoFromJson(jsonData);
        return userinfo;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Fetch Products From Endpoint (getProducts)
  static Future<List<Product>?> fetchProducts() async {
    var endpoint = 'getProducts';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  static Future filterProducts(String title) async {
    var endpoint = 'filterProducts/${title}';
    var response = await client.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var items = jsonData;
      return items;
    } else {
      return [];
    }
  }



  //Fetch Items Recently From Endpoint (getProduct)
  static Future<List<Product>?> fetchProductsRecently(int page, int limit) async {
    var endpoint = 'getProductsRecently/$page/$limit';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //add new bill To Endpoint (addBill)
  static Future<String> addBill(String name, String phone, String city, String address, int price, int delivery, List<Map<String, dynamic>> items, user_id , customer_name , customer_total , customer_nearpoint , profit, note) async {
    var endpoint = 'addBill';
    var body = jsonEncode({
      'name': name,
      'phone': phone,
      'city': city,
      'address': address,
      'price': price,
      'delivery': delivery,
      'items': items,
      'user_id':user_id,
      'customer_name' : customer_name,
      'customer_total' : customer_total,
      'profit': profit,
      'customer_nearpoint' : customer_nearpoint,
      'note': note
    });
    try {
      var response = await http.post(
        Uri.parse(baseUrl + endpoint),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonData;
      } else {
        String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }
  //Fetch Bills By Id From Endpoint (getBills)
  static Future<List<Bill>?> fetchBills(id) async {
    var endpoint = 'getBills/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Bill> bills = billFromJson(jsonData);
        return bills;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Bills By Id From Endpoint (getBills)
  static Future<List<Bill>?> fetchLatestBills(id) async {
    var endpoint = 'getBillsLastest/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Bill> bills = billFromJson(jsonData);
        return bills;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //
  static Future<List<Sale>?> getBill(id) async {
    var endpoint = 'getBill/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Sale> Sales = saleFromJson(jsonData);
        return Sales;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Item By Id From Endpoint (getProduct)
  static Future<List<Product>?> fetchProductone(id) async {
    var endpoint = 'getProduct/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Items By Category From Endpoint (getProductByCategory)
  static Future<List<Product>?> fetchProductByCate(id) async {
    var endpoint = 'getProductByCategory/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Fetch Sliders From Endpoint (getSliders)
  static Future<List<SliderBar>?> fetchSliders() async {
    var endpoint = 'getSliders';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<SliderBar> sliders = sliderFromJson(jsonData);
        return sliders;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Sliders From Endpoint (getCategories)
  static Future<List<CategoryModel>?> fetchCategories() async {
    var endpoint = 'getCategories';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<CategoryModel> categories = categoryModelFromJson(jsonData);
        return categories;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}