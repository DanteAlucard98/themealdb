import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  static const String _key = 'favorite_meals';
  final Set<String> _favoriteMeals = {};
  bool _isInitialized = false;

  Future<void> _initializeIfNeeded() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_key);
    if (favoritesJson != null) {
      final List<dynamic> favorites = json.decode(favoritesJson);
      _favoriteMeals.addAll(favorites.cast<String>());
    }
    _isInitialized = true;
  }

  Future<void> toggleFavorite(String mealId) async {
    await _initializeIfNeeded();
    
    if (_favoriteMeals.contains(mealId)) {
      _favoriteMeals.remove(mealId);
    } else {
      _favoriteMeals.add(mealId);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(_favoriteMeals.toList()));
  }

  Future<bool> isFavorite(String mealId) async {
    await _initializeIfNeeded();
    return _favoriteMeals.contains(mealId);
  }

  Future<List<String>> getFavorites() async {
    await _initializeIfNeeded();
    return _favoriteMeals.toList();
  }
} 