import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/models/Category.dart';
import 'package:flutter_api_frontend/providers/AuthProvider.dart';
import 'package:flutter_api_frontend/services/api.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  CategoryProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);

    init();
  }

  Future init() async {
    categories= await apiService.fetchCategories();
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    try {
      Category addedCategory = await apiService.addCategory(name);
      categories.add(addedCategory);

      notifyListeners();
    } catch (Exception) {
      await authProvider.logout();
    }
  }

  Future updateCategory(Category category) async {
    try {
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;

      notifyListeners();
    } catch (Exception) {
      await authProvider.logout();
    }
  }

  Future deleteCategory(Category category) async {
    try {
      await apiService.deleteCategory(category.id);
      categories.remove(category);

      notifyListeners();
    } catch (Exception) {
      await authProvider.logout();
    }
  }
}