import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movieapp/widgets/movie_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  String? searchText;

  Future<Map<String, dynamic>> getMovies() async {
    if (searchText == null || searchText!.isEmpty) {
      // Return an early response when no search term is entered
      return {'contents': []};
    }

    const String url = 'https://movies-api14.p.rapidapi.com/search';
    const String apiKey = '28564b5c6amsh27e9c807f3c66cdp156d3djsn4b7343b99a58';

    try {
      final response = await http.get(
        Uri.parse('$url?query=$searchText'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('contents')) {
          return data;
        } else {
          throw 'Invalid API response format';
        }
      } else {
        throw 'Failed to fetch data: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter the Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onEditingComplete: () {
                setState(() {
                  searchText = _controller.text;
                });
                
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
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
                    snapshot.data as Map<String, dynamic>? ?? {};
                final List<dynamic> movieResults =
                    movies['contents'] as List<dynamic>? ?? [];

                if (searchText == null || searchText!.isEmpty) {
                  // Show a message or UI prompting the user to enter a search term
                  return Center(
                    child: Text('Please enter a search term'),
                  );
                }

                return ListView.builder(
                  itemCount: movieResults.length,
                  itemBuilder: (context, index) {
                    final movie = movieResults[index];
                    return MovieCard(
                      title: movie['title'],
                      image: movie['poster_path'],
                      result: movie,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
