import 'package:flutter/material.dart';

class NewsSearchDelegate extends SearchDelegate<String> {
  final List<String> countries = ['us', 'in', 'fr'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = query;
    return Center(
      child: ListTile(
        title: Text('Selected Country: $result'),
        onTap: () {
          close(context, result);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = countries.where((country) {
      return country.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final country = suggestions[index];
        return ListTile(
          title: Text(country),
          onTap: () {
            close(context, country);
          },
        );
      },
    );
  }
}
