import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final dynamic article;

  MessageScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article title
                Text(
                  article['title'] ?? 'No Title',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'NotoSans',
                  ),
                ),
                SizedBox(height: 8),
                // Published date
                Text(
                  'Published on: ${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontFamily: 'NotoSans',
                  ),
                ),
                SizedBox(height: 20),
                // Article description or content
                Text(
                  article['content'] ?? 'No content available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'NotoSans',
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                // Display article URL as text, if available
                article['url'] != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Icon(Icons.link, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              article['url'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
