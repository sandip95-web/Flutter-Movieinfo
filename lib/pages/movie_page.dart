import 'package:flutter/material.dart';
import 'package:movieapp/widgets/movie_card.dart';

class MoviePage extends StatelessWidget {
  final Map<String, dynamic> result;
  const MoviePage({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      title: result['title'],
      image: result['poster_path'],
      result: result,
    );
  }
}
