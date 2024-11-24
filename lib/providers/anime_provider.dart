import 'package:flutter/material.dart';

class AnimeProvider with ChangeNotifier {
  final List<dynamic> _favorites = [];

  List<dynamic> get favorites => _favorites;

  bool isFavorite(dynamic anime) {
    return _favorites.any((element) => element['mal_id'] == anime['mal_id']);
  }

  void toggleFavorite(dynamic anime) {
    if (isFavorite(anime)) {
      _favorites.removeWhere((element) => element['mal_id'] == anime['mal_id']);
    } else {
      _favorites.add(anime);
    }
    notifyListeners();
  }
}
