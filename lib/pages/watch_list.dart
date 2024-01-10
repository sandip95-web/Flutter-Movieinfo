import 'package:flutter/material.dart';
import 'package:movieapp/provider/movie_provider.dart';
import 'package:movieapp/widgets/movie_detail_page.dart';
import 'package:provider/provider.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    final list = (Provider.of<MovieProvider>(context).movielist);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch List'),
        backgroundColor: Colors.blue[200],
      ),
      body: SizedBox(
        height: double.infinity,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            return Container(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MovieDetailPage(result: item);
                      },
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(item['poster_path']),
                  title: Text(item['title']),
                  trailing: IconButton(
                    onPressed: () {
                      Provider.of<MovieProvider>(context, listen: false)
                          .removieMovie(item);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 32,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
