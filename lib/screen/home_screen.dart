import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ujian_flutter/screen/detail_anime_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> topAnime = [];
  List<dynamic> ongoingAnime = [];

  @override
  void initState() {
    super.initState();
    fetchTopAnime();
    fetchOngoingAnime();
  }

  Future<void> fetchTopAnime() async {
    final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        topAnime = json['data'].take(10).toList();
      });
    }
  }

  Future<void> fetchOngoingAnime() async {
    final response = await http.get(Uri.parse('https://api.jikan.moe/v4/seasons/now'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        ongoingAnime = json['data'].take(6).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Anime', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20,color: Colors.red, fontWeight: FontWeight.bold),),
            Text('Blog', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18,),),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Anime', style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 10,),
            topAnime.isEmpty
              ? CircularProgressIndicator()
              : CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16/9,
                    autoPlayCurve: Curves.easeInSine,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: topAnime.map((anime) {
                    return InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailAnimeScreen(anime: anime))),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(anime['images']['jpg']['large_image_url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                anime['title'],
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Ongoing ', style: Theme.of(context).textTheme.titleMedium,),
                    Text('Anime', style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
                TextButton(
                  onPressed: (){}, 
                  child: Text('More...', style: TextStyle(color: Colors.red),),
                )
              ],
            ),
            SizedBox(height: 10,),
            ongoingAnime.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: ongoingAnime.length,
                  itemBuilder: (context, index) {
                    final anime = ongoingAnime[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailAnimeScreen(anime: anime)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(anime['images']['jpg']['large_image_url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  anime['title'],
                                  style: Theme.of(context).textTheme.titleSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
