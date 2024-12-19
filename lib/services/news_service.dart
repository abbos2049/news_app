import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = 'a702480fff8543fb83f6e2e39106f8d3';  // Replace with your actual API key
  final String baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<dynamic>> fetchNews(String country) async {
    final response = await http.get(
      Uri.parse('$baseUrl?country=$country&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
