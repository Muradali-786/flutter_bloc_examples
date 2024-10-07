import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class Repository {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/comments';
  Future<List<PostModel>> fetchApi(int page, int limit) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl?_page=$page&_limit=$limit'));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        return body.map((e) {
          return PostModel(
            id: e['id'] as int,
            name: e['name'] as String,
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception('Error while fetching API data: $e');
    }
  }
}
