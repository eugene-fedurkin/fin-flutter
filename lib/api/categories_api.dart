import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/utils/constants.dart';
import 'package:http/http.dart' as http;

class CategoriesApi {
  List<Category> fetchCategories() {
    // var uri = Uri.https(Constants.BASE_URL_DOMAIN, Constants.FORECAST_PATH, query);

    // log('${uri.toString()}');
    
    // var response = await http.get(uri);

    // print(response.body);

    // if (response.statusCode == 200) {
    //   return Category.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception('Error response');
    // }
    return [
      Category(icon: Icons.local_grocery_store_outlined, name: 'Shop', color: Colors.teal.shade100),
      Category(icon: Icons.airport_shuttle_outlined, name: 'Transport', color: Colors.blue.shade100),
      Category(icon: Icons.family_restroom, name: 'Family', color: Colors.red.shade400),
      Category(icon: Icons.card_giftcard, name: 'Gifts', color: Colors.green.shade200),
      Category(icon: Icons.home, name: 'Home', color: Colors.blue.shade100),
      Category(icon: Icons.local_cafe, name: 'Cafe', color: Colors.yellow.shade300)
    ];
  }
}