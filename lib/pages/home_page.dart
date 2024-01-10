import 'package:flutter/material.dart';
import 'package:movieapp/pages/search_page.dart';
import 'package:movieapp/pages/watch_list.dart';
import 'package:movieapp/widgets/movie_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Icon(Icons.movie),
          ),
        ),
        title: const Text('MovieInfo'),
        backgroundColor: Colors.amber,
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu_sharp,
                size: 32,
              ),
            );
          }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'MovieInfo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle home menu item click
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
              ),
              title: const Text('Watch List'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const WatchList();
                  },
                ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search,
              ),
              title: const Text('Search'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const SearchPage();
                  },
                ));
              },
            ),
          ],
        ),
      ),
      body: const MovieList(),
    );
  }
}
