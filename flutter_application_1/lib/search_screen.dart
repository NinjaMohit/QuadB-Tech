// screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  TextEditingController searchController = TextEditingController();

  Future<void> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(
                  color: Colors.black), // Set text color to black

              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.grey[200], // Background color for TextField
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchResults.clear();
                    });
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Circular border
                  borderSide: BorderSide.none, // Remove default border
                ),
              ),
              onSubmitted: searchMovies,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index]['show'];

                return ListTile(
                  leading: movie['image'] != null
                      ? Image.network(
                          movie['image']['medium'],
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/no-img-portrait-text.png',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                  title: Text(movie['name'] ?? 'No Title Available'),
                  subtitle: Text(
                    movie['summary']
                            ?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '') ??
                        'No Summary Available',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
