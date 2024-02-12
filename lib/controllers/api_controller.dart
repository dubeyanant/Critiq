import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIController extends GetxController {
  List<dynamic> apiDataList = [].obs;
  RxString itemName = ''.obs;

  Future<List<dynamic>> fetchBooks() async {
    String? apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];
    String query = itemName.value;

    var response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
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

  Future<List<dynamic>> fetchMovies() async {
    String url = 'https://api.themoviedb.org/3/search/movie';
    String query = itemName.value;

    Uri uri =
        Uri.parse('$url?query=$query&include_adult=true&language=en-US&page=1');

    var response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['TMDB_READ_ACCESS_TOKEN']}',
        'Host': 'api.themoviedb.org',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // print(data['results']);
      apiDataList = data['results'];
      return apiDataList;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
