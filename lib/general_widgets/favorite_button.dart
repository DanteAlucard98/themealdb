import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/favorite_meals/favorite_meals_bloc.dart';
import 'package:recetas_adpp_2025/services/favorites_service.dart';

class FavoriteButton extends StatefulWidget {
  final String mealId;
  final double size;
  final Color? color;
  final Function(bool)? onFavoriteChanged;

  const FavoriteButton({
    Key? key,
    required this.mealId,
    this.size = 24.0,
    this.color,
    this.onFavoriteChanged,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavoritesService _favoritesService = FavoritesService();
  bool _isFavorite = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await _favoritesService.isFavorite(widget.mealId);
    if (mounted && !_isInitialized) {
      setState(() {
        _isFavorite = isFavorite;
        _isInitialized = true;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    await _favoritesService.toggleFavorite(widget.mealId);
    if (mounted) {
      setState(() {
        _isFavorite = !_isFavorite;
      });
      widget.onFavoriteChanged?.call(_isFavorite);
      
      // Notify the FavoriteMealsBloc to refresh the list
      if (context.mounted) {
        context.read<FavoriteMealsBloc>().add(RefreshFavoriteMeals());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : widget.color ?? Colors.grey,
        size: widget.size,
      ),
      onPressed: _toggleFavorite,
      splashRadius: widget.size * 0.8,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: widget.size * 1.5,
        minHeight: widget.size * 1.5,
      ),
    );
  }
} 