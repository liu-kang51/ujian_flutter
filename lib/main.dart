import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujian_flutter/screen/home_screen.dart';
import 'providers/anime_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AnimeProvider(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins'
        ),
        debugShowCheckedModeBanner: false,
        title: 'Michael Wibu',
        darkTheme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
