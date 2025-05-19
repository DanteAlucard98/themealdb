import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/detail_meals/widgets/expandable_card.dart';
import 'package:recetas_adpp_2025/general_widgets/network_image_with_fallback.dart';

//Clase para obtener el contenido de la comida específica
class DetailMealsContent extends StatefulWidget {
  final Meal meal;
  
  const DetailMealsContent({
    super.key,
    required this.meal,
  });

  @override
  State<DetailMealsContent> createState() => _DetailMealsContentState();
}

class _DetailMealsContentState extends State<DetailMealsContent> {
  static const double maxHeaderHeight = 300;
  static const double minHeaderHeight = 120;

  final ScrollController _scrollController = ScrollController();
  double _headerHeight = maxHeaderHeight;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final offset = _scrollController.offset;
    final newHeight = (maxHeaderHeight - offset).clamp(minHeaderHeight, maxHeaderHeight);
    
    if (newHeight != _headerHeight) {
      setState(() {
        _headerHeight = newHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          //Imagen animada del header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: _headerHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: widget.meal.idMeal,
                    child: NetworkImageWithFallback(
                      imageUrl: widget.meal.strMealThumb,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Text(
                        widget.meal.strMeal,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Contenido scrollable
          Positioned.fill(
            top: _headerHeight - 20,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Información básica de la comida
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              avatar: const Icon(Icons.category, size: 18, color: Colors.white),
                              label: Text(widget.meal.strCategory, style: const TextStyle(color: Colors.white)),
                              backgroundColor: AppColors.primary,
                            ),
                            Chip(
                              avatar: const Icon(Icons.public, size: 18, color: Colors.white),
                              label: Text(widget.meal.strArea, style: const TextStyle(color: Colors.white)),
                              backgroundColor: AppColors.secondary,
                            ),
                          ],
                        ),
                      ),
                      
                        // Ingredients section - expandible
                      ExpandableCard(
                        title: 'Ingredients',
                        icon: Icons.restaurant,
                        iconColor: AppColors.primary,
                        gradientColors: [
                          AppColors.primary.withOpacity(0.15),
                          AppColors.secondary.withOpacity(0.05),
                        ],
                        gradientBegin: Alignment.topLeft,
                        gradientEnd: Alignment.bottomRight,
                        children: List.generate(widget.meal.ingredients.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                Icon(Icons.fiber_manual_record, size: 12, color: AppColors.secondary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.meal.ingredients[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.meal.measures[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textPrimary.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      
                      // Instrucciones sección - expandible
                      ExpandableCard(
                        title: 'Instructions',
                        icon: Icons.menu_book,
                        iconColor: AppColors.secondary,
                        gradientColors: [
                          AppColors.secondary.withOpacity(0.15),
                          AppColors.primary.withOpacity(0.05),
                        ],
                        gradientBegin: Alignment.topLeft,
                        gradientEnd: Alignment.bottomRight,
                        children: [
                          Text(
                            widget.meal.strInstructions,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}