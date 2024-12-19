import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';
import 'package:news_app/delegates/news_search_delegate.dart';
import 'message_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String _selectedCountry = 'us';
  final String _apiKey = 'a702480fff8543fb83f6e2e39106f8d3'; // Replace with your actual API key

  Future<List<Article>> fetchNews(String country) async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'];

        return articles.map((article) => Article.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? result = await showSearch<String>(
                context: context,
                delegate: NewsSearchDelegate(),
              );
              if (result != null) {
                setState(() {
                  _selectedCountry = result;
                });
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Country:'),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedCountry,
                    items: const [
                      DropdownMenuItem(value: 'us', child: Text('USA')),
                      DropdownMenuItem(value: 'in', child: Text('India')),
                      DropdownMenuItem(value: 'fr', child: Text('France')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCountry = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: fetchNews(_selectedCountry),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No articles found.'));
                  } else {
                    final articles = snapshot.data!;
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: article.urlToImage.isNotEmpty
                                ? Image.network(
                                    article.urlToImage,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image_not_supported),
                            title: Text(
                              article.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              article.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessageScreen(article: {
                                    'title': article.title,
                                    'publishedAt': article.publishedAt,
                                    'content': article.description,
                                    'url': article.url,
                                  }),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
