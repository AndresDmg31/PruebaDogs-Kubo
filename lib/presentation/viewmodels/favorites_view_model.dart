import 'package:dogs/domain/entities/breed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class FavoritesProvider extends ChangeNotifier {
  final List<Breed> _favorites = [];

  List<Breed> get favorites => List.unmodifiable(_favorites);

  FavoritesProvider() {
    _loadFromPrefs();
  }

  bool isFavorite(Breed breed) {
    return _favorites.any((b) => b.id == breed.id);
  }

  void toggleFavorite(Breed breed) {
    if (isFavorite(breed)) {
      _favorites.removeWhere((b) => b.id == breed.id);
    } else {
      _favorites.add(breed);
    }
    notifyListeners();
    _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _favorites.map((b) => jsonEncode(b.toJson())).toList();
    await prefs.setStringList("favorites", list);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("favorites") ?? [];
    _favorites.clear();
    _favorites.addAll(list.map((str) => Breed.fromJson(jsonDecode(str))));
    notifyListeners();
  }
}


