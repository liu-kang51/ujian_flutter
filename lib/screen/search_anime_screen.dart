import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ujian_flutter/screen/detail_anime_screen.dart';

class SearchAnimeScreen extends StatefulWidget {
  const SearchAnimeScreen({super.key});

  @override
  State<SearchAnimeScreen> createState() => _SearchAnimeScreenState();
}

class _SearchAnimeScreenState extends State<SearchAnimeScreen> {
  List<dynamic> searchResults = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  Future<void> searchAnime(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://api.jikan.moe/v4/anime?q=$query&sfw=true'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          searchResults = json['data'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Anime',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => searchAnime(value),
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Search anime...',
                prefixIcon: Icon(Icons.search, color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                filled: true,
                fillColor: Color(0xFF262626),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.red))
                : searchResults.isEmpty
                    ? Center(
                        child: Text(
                          _searchController.text.isEmpty
                              ? 'Search for your favorite anime'
                              : 'No results found',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final anime = searchResults[index];
                          return Card(
                            color: Color(0xFF262626),
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  anime['images']['jpg']['image_url'],
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                anime['title'],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Text(
                                '${anime['type']} • ${anime['episodes'] ?? '?'} Episodes',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${anime['score'] ?? '?'}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailAnimeScreen(anime: anime),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
