import 'package:flutter/material.dart';
import 'package:organizer/models/category.dart';

class SharedState extends ChangeNotifier {
  CategoryModel? activeCategory;

  void selectCategory(CategoryModel category) {
    activeCategory = category;

    notifyListeners();
  }
}