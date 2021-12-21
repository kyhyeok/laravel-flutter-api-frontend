import 'dart:convert';
import 'dart:io';

import 'package:flutter_api_frontend/models/Category.dart';
import 'package:http/http.dart' as http;
class ApiService {
  ApiService();

  final String baseUrl = 'http://10.0.2.2:8000/api/';

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http
        .get(Uri.parse(baseUrl + 'categories'));

    List categories =jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future<Category> addCategory(String name) async {
    String uri = baseUrl + 'categories';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({ 'name': name })
    );

    if (response.statusCode != 201) {
      throw Exception('Error happened on save');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<Category> updateCategory(Category category) async {
    String uri = baseUrl + 'categories/' + category.id.toString();

    http.Response response = await http.patch(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(({'name' : category.name}))
    );

    if (response.statusCode != 200) {
      throw Exception('Error happened on update');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteCategory(id) async {
    String uri = baseUrl + 'categories/' + id.toString();
    http.Response response = await http.delete(Uri.parse(uri));

    if (response.statusCode != 204) {
      throw Exception('Error happened on delete');
    }
  }
}