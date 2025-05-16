class Meal {
  final String idMeal;
  final String strMeal;
  final String strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strTags;
  final String strYoutube;
  final String strSource;
  final String strImageSource;
  final String strCreativeCommonsConfirmed;
  final String dateModified;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    required this.strSource,
    required this.strImageSource,
    required this.strCreativeCommonsConfirmed,
    required this.dateModified,
    required this.ingredients,
    required this.measures,
  });
}