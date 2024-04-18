import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ui_ecommerce/models/Category.dart';
import 'package:ui_ecommerce/models/Product.dart';
import '../models/Slider.dart';

class RemoteServices {
  static var client = http.Client();
  static var baseUrl = 'http://127.0.0.1:3000/';
  //Fetch Sliders From Endpoint (getProducts)
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