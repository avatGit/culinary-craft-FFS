import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/add_recipe/add_recipe_screen.dart';
import '../presentation/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/recipe_detail/recipe_detail_screen.dart';
import '../presentation/screens/recipe_list/recipe_list_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final RecipesRepository repository;

  AppRouter(this.repository);

  late final GoRouter router = GoRouter(
    initialLocation: '/recipes',
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      GoRoute(
        path: '/recipes',
        name: 'recipes',
        builder: (context, state) => RecipeListScreen(repository: repository),
      ),
      GoRoute(
        path: '/recipe/:id',
        name: 'recipe-detail',
        builder: (context, state) {
          final recipeId = state.pathParameters['id'] ?? '';
          return RecipeDetailScreen(recipeId: recipeId, repository: repository);
        },
      ),
      GoRoute(
        path: '/add-recipe',
        name: 'add-recipe',
        builder: (context, state) => AddRecipeScreen(repository: repository),
      ),
    ],

    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: const Text('Page non trouvee.'))),
  );
}
