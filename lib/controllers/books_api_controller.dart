import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BooksAPIController extends GetxController {
  Future<void> fetchBooks() async {
    String? apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];
    const String query = 'Project Hail Mary'; // Example query

    var response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];

      // Process the book data
      for (var item in items) {
        print(item['volumeInfo']['title']);
      }
    } else {
      throw Exception('Failed to load books');
    }
  }
}
