import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BooksAPIController extends GetxController {
  List<dynamic> apiDataList = [].obs;
  RxString itemName = ''.obs;
  RxBool isSearched = false.obs;

  Future<List<dynamic>> fetchBooks() async {
    while (!isSearched.value) {
      await Future.delayed(const Duration(seconds: 1));
    }

    String? apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];
    String query = itemName.value;

    var response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = jsonDecode(response.body);
      apiDataList = data['items'];

      // for (var data in apiDataList) {
      //   print(data['volumeInfo']['imageLinks']);
      // }
      return apiDataList;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
