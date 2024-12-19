import 'package:flutter/material.dart';
import 'package:news_app/screens/news_screen.dart';

void main() {
  runApp(const NewsApp());
}


class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          // Update with the new TextTheme parameters
          bodyLarge: TextStyle(fontFamily: 'NotoSans'),
          bodyMedium: TextStyle(fontFamily: 'NotoSans'),
          bodySmall: TextStyle(fontFamily: 'NotoSans'),
          headlineLarge: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold),
          // Add more text styles if needed
        ),
      ),
      home: const NewsScreen(),
    );
  }
}