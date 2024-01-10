import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  final Map<String, dynamic> result;
  const MovieInfo({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(children: [
                  Image.network(
                    result['poster_path'] ??
                        'https://as2.ftcdn.net/v2/jpg/00/89/55/15/1000_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg',
                    width: 150,
                    height: 200,
                  )
                ]),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result['release_date'] ?? '-'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        result['title'],
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(result['original_title'] ?? '-'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('${result['vote_average']}/10'),
                      Text('${result['vote_count']} Ratings'),
                      Text('Format: ${result['contentType'] ?? '-'}')
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result['overview']),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Source',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: result['sources'].length,
                    itemBuilder: (context, index) {
                      final item = result['sources'][index];
                      return Chip(
                        label: Text(
                          item['source'],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Tags',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: result['genres'].length,
                    itemBuilder: (context, index) {
                      final item = result['genres'][index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(
                            item,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
