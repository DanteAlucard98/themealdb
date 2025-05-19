import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//Servicio de favoritos
class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  //Clave de los favoritos
  static const String _key = 'favorite_meals';

  //Lista de comidas favoritas
  final Set<String> _favoriteMeals = {};

  //Inicializar los favoritos
  bool _isInitialized = false;

  //Inicializar los favoritos
  Future<void> _initializeIfNeeded() async {
    if (_isInitialized) return;

    //Obtener las preferencias compartidas
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_key);
    if (favoritesJson != null) {
      final List<dynamic> favorites = json.decode(favoritesJson);
      _favoriteMeals.addAll(favorites.cast<String>());
    }
    _isInitialized = true;
  }

  //Cambiar el estado de los favoritos
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

  //Verificar si la comida es favorita
  Future<bool> isFavorite(String mealId) async {
    await _initializeIfNeeded();
    return _favoriteMeals.contains(mealId);
  }

  //Obtener los favoritos
  Future<List<String>> getFavorites() async {
    await _initializeIfNeeded();
    return _favoriteMeals.toList();
  }
} 