import 'package:flutter_test/flutter_test.dart';
import 'package:culinary_craft/data/models/recipe.dart';
import 'package:culinary_craft/data/repositories/recipe_repository.dart';

void main() {
  group('RecipeRepositoryImpl Tests', () {
    late RecipeRepositoryImpl repository;

    setUp(() {
      repository = RecipeRepositoryImpl();
    });

    test('getAllRecipes doit retourner la liste initiale des recettes', () {
      final recipes = repository.getAllRecipes();
      expect(recipes.isNotEmpty, true);
      expect(recipes.length, 6); // On a 6 recettes par défaut
    });

    test('getRecipeById doit retourner la bonne recette pour un ID existant', () {
      const targetId = '1';
      final recipe = repository.getRecipeById(targetId);
      expect(recipe, isNotNull);
      expect(recipe?.id, targetId);
      expect(recipe?.title, 'Pasta Carbonara');
    });

    test('getRecipeById doit retourner null pour un ID inexistant', () {
      final recipe = repository.getRecipeById('999');
      expect(recipe, isNull);
    });

    test('addRecipe doit ajouter une nouvelle recette et notifier les écouteurs', () {
      bool notified = false;
      repository.addListener(() {
        notified = true;
      });

      final newRecipe = Recipe(
        id: 'test_id',
        title: 'Test Recipe',
        category: 'Test',
        duration: 10,
        ingredients: ['Ingredient 1'],
        instructions: ['Step 1'],
        imageUrl: 'https://test.com/image.png',
        difficulty: 'Facile',
      );

      repository.addRecipe(newRecipe);

      final recipes = repository.getAllRecipes();
      expect(recipes.contains(newRecipe), true);
      expect(notified, true); // Vérifie que notifyListeners() a bien fonctionné
    });
  });
}
