import 'package:flutter/material.dart';
import 'package:movieapp/gloal_data.dart';
import 'package:movieapp/widgets/movie_info.dart';
import 'package:movieapp/widgets/video.dart';

class MovieDetailPage extends StatefulWidget {
  final Map<String, dynamic> result;
  const MovieDetailPage({
    super.key,
    required this.result,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late String selectedFilter;
  @override
  void initState() {
    super.initState();

    selectedFilter = detailFilter[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.result['title']),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: detailFilter.length,
              itemBuilder: (context, index) {
                final item = detailFilter[index];
                return Container(
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
                      side: BorderSide.none,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                );
              },
            ),
          ),
          selectedFilter == 'Info'
              ? Expanded(
                  child: MovieInfo(
                    result: widget.result,
                  ),
                )
              : Video(
                  videoUrl: widget.result['youtube_trailer'],
                  title: widget.result['title'],
                )
        ],
      ),
    );
  }
}
