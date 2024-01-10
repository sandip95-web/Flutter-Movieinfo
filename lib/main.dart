import 'package:flutter/material.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/provider/movie_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> MovieProvider(),
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        title: 'MovieInfo',
        theme: ThemeData(
          fontFamily: 'Sansita',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 128, 128, 1.0),
            primary: const Color.fromRGBO(0, 128, 128, 1.0),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
