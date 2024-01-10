import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> movielist = [];

  void addMovie(Map<String, dynamic> movie) {
    movielist.add(movie);
    notifyListeners();
  }
  void removieMovie(Map<String, dynamic> movie) {
    movielist.remove(movie);
    notifyListeners();
  }
}
