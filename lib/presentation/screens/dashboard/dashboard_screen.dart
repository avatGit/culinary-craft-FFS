import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/recipe.dart';

class DashboardScreen extends StatelessWidget {
  final RecipesRepository repository;

  const DashboardScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final recipes = repository.getAllRecipe();

    // Nombre total de recettes
    final totalRecipes = recipes.length;

    // `.toSet()` supprime automatiquement les doublons.
    final categoriesCount = recipes.map((r) => r.category).toSet().length;

    final double avgDuration = recipes.isEmpty
        ? 0
        : recipes.fold(0, (sum, recipe) => sum + recipe.duration) /
              totalRecipes;

    final easyRecipesCount = recipes
        .where((r) => r.difficulty.toLowerCase() == 'Facile')
        .length;

    // Recuperer la derniere recette
    final Recipe? latestRecipe = recipes.isNotEmpty ? recipes.last : null;
    // TODO: implement build
    throw UnimplementedError();
  }
}
