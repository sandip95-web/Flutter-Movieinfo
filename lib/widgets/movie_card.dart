import 'package:flutter/material.dart';
import 'package:movieapp/provider/movie_provider.dart';
import 'package:movieapp/widgets/movie_detail_page.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatefulWidget {
  final String title;
  final String image;
  final Map<String, dynamic> result;

  const MovieCard({
    Key? key,
    required this.title,
    required this.image,
    required this.result,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool set = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MovieDetailPage(
                result: widget.result,
              );
            },
          ),
        );
      },
      child: Card(
        elevation: 4.0, // Add elevation for a card-like appearance
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          title: Text(widget.title),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(
                8.0), // Optional: Add border radius for a rounded image
            child: Image.network(
              widget.image,
              width: 80.0, // Set the width as needed
              height: double.infinity, // Fill the entire available height
              fit: BoxFit.cover, // Use BoxFit.fill to stretch the image
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                set = !set;
              });
              if (set == true) {
                Provider.of<MovieProvider>(context, listen: false)
                    .addMovie(widget.result);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to your Watch List'),
                  ),
                );
              } else {
                Provider.of<MovieProvider>(context, listen: false)
                    .removieMovie(widget.result);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Removed from your Watch List'),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.bookmark,
              color: set == true ? Colors.green : null,
            ),
          ),
          visualDensity: const VisualDensity(vertical: 4.0),
        ),
      ),
    );
  }
}
