import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GalleryView extends StatelessWidget {
  final List<String> images = [
    'https://via.placeholder.com/400',
    'https://via.placeholder.com/500',
    'https://via.placeholder.com/600',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(height: 400.0),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(image, fit: BoxFit.cover),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
