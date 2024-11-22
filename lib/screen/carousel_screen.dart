import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (ctx, postProvider, _) {
        return FutureBuilder(
          future: postProvider.fetchPosts(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final posts = postProvider.posts;
            return CarouselSlider(
              options: CarouselOptions(height: 200.0, autoPlay: true),
              items: posts.map((post) {
                return Builder(
                  builder: (ctx) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(post.title, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(post.body, textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
