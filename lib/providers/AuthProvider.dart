import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/services/api.dart';

class AuthProvider extends ChangeNotifier {

  bool isAuthenticated = false;
  late String token;

  ApiService apiService = new ApiService('');

  Future<void> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {

    token = await apiService.register(name, email, password, passwordConfirm, deviceName);
    notifyListeners();

    isAuthenticated = true;
  }

  Future<void> login(String email, String password, String deviceName) async {

    token = await apiService.login(email, password, deviceName);
    notifyListeners();

    isAuthenticated = true;
  }

  Future<void> logOut() async {
    token = '';
    isAuthenticated = false;
    notifyListeners();
  }
}