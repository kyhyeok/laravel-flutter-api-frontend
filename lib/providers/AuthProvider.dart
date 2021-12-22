import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  late String token;
  late ApiService apiService;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    this.token = await getToken();
    if (this.token.isNotEmpty) {
      this.isAuthenticated = true;
    }
    this.apiService = new ApiService(this.token);
    notifyListeners();
  }

  Future<void> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {
    this.token = await apiService.register(
        name, email, password, passwordConfirm, deviceName);
    this.isAuthenticated = true;
    setToken(this.token);
    notifyListeners();
  }

  Future<void> login(String email, String password, String deviceName) async {
    this.token = await apiService.login(email, password, deviceName);
    this.isAuthenticated = true;
    setToken(this.token);
    notifyListeners();
  }

  Future<void> logOut() async {
    this.token = '';
    this.isAuthenticated = false;
    setToken(this.token);
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}
