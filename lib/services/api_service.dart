import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return List<PostModel>.from(json.map((e) => PostModel.fromJson(e)));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
