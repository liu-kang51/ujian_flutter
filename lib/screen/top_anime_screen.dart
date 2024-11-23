import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopAnimeScreen extends StatelessWidget {
  const TopAnimeScreen({super.key});
  

  Future<dynamic> getAnimeFromApi() async {
    final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));
    final json = jsonDecode(response.body);
    return json;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Michael ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            Flexible(
              child: Text(
                'Wibu', 
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAnimeFromApi(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                mainAxisSpacing: 10, 
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                final animeData = snapshot.data['data'][index];
                final imageAnime = animeData['images']['jpg']['image_url'];
                final titleAnime = animeData['title'];
                return Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          imageAnime,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        titleAnime,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }
            );
          } else {
            return Center(child: Text('Fetch error'));
          }
        }
      ),
    );
  }
}