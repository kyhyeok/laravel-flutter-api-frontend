import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/models/Category.dart';
import 'package:flutter_api_frontend/services/api.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  late ApiService apiService;

  CategoryProvider() {
    this.apiService = ApiService();

    init();
  }

  Future init() async {
    categories= await apiService.fetchCategories();
    notifyListeners();
  }

  Future updateCategory(Category category) async {
    try {
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}