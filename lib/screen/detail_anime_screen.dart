import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujian_flutter/providers/anime_provider.dart';

class DetailAnimeScreen extends StatelessWidget {
  final dynamic anime;

  const DetailAnimeScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                anime['title'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    anime['images']['jpg']['large_image_url'],
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 28),
                          Text(
                            ' ${anime['score']}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          anime['status'] ?? 'Unknown',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF262626),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoColumn('Episodes', '${anime['episodes'] ?? '?'}'),
                        _buildInfoColumn('Duration', '${anime['duration'] ?? '?'}'),
                        _buildInfoColumn('Rating', '${anime['rating']?.split(' ')[0] ?? '?'}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Synopsis',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime['synopsis'] ?? 'No synopsis available',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Genres',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (anime['genres'] as List<dynamic>).map((genre) {
                      return Chip(
                        label: Text(genre['name']),
                        backgroundColor: Colors.red.withOpacity(0.2),
                        side: BorderSide(color: Colors.red),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<AnimeProvider>(
        builder: (context, animeProvider, child) {
          return FloatingActionButton(
            onPressed: () {
              animeProvider.toggleFavorite(anime);
            },
            backgroundColor: Colors.red,
            child: Icon(
              animeProvider.isFavorite(anime) 
                  ? Icons.favorite 
                  : Icons.favorite_border
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
