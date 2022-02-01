import 'package:flutter/material.dart';
import 'package:organizer/models/category.dart';

class SharedState extends ChangeNotifier {
  Category? activeCategory;

  void selectCategory(Category category) {
    activeCategory = category;

    notifyListeners();
  }
}