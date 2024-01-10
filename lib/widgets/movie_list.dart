import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movieapp/gloal_data.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/pages/all_page.dart';
import 'package:movieapp/pages/movie_page.dart';
import 'package:movieapp/pages/series_page.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late String selectedFilter;

  Future<Map<String, dynamic>> getMovies() async {
    const String url = 'https://movies-api14.p.rapidapi.com/search';
    const String apiKey = '28564b5c6amsh27e9c807f3c66cdp156d3djsn4b7343b99a58';
    const String query = 'Stranger';
    try {
      final response = await http.get(
        Uri.parse('$url?query=$query'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com',
        },
      );
      final data = jsonDecode(response.body);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getMovies();
    selectedFilter = filter[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            final Map<String, dynamic> movies =
                snapshot.data as Map<String, dynamic>;
            final List<dynamic> movieResults =
                movies['contents'] as List<dynamic>;

            return Column(
              children: [
                Container(
                  color: const Color.fromARGB(193, 255, 193, 7),
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filter.length,
                    itemBuilder: (context, index) {
                      final item = filter[index];
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedFilter == item
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = item;
                            });
                          },
                          child: Chip(
                            label: Text(item),
                            backgroundColor:
                                const Color.fromARGB(193, 255, 193, 7),
                            side: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: movieResults.length,
                    itemBuilder: (context, index) {
                      final movie = movieResults[index];

                      if (selectedFilter == 'Movies') {
                        if (movie['contentType'] == 'movie') {
                          return MoviePage(
                            result: movie,
                          );
                        }
                      } else if (selectedFilter == 'Series') {
                        return SeriesPage(
                          result: movie,
                        );
                      } else if (selectedFilter == 'All') {
                        return AllPage(
                          result: movie,
                        );
                      }
                      return null;
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
