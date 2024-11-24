import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujian_flutter/screen/main_screen.dart';
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
        theme: ThemeData.dark().copyWith(
           textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontFamily: 'Poppins', color: Colors.white,),
            bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.white,),
            titleLarge: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 16, fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold),
          ),
          scaffoldBackgroundColor: const Color(0xFF1A1A1A),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF262626),
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Michael Wibu',
        home: const MainScreen(),
      ),
    );
  }
}
