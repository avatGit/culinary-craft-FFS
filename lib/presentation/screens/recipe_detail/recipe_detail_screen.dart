import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:culinary_craft/presentation/widgets/difficulty_badge.dart';
import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  // Passage au type abstrait RecipeRepository
  final RecipeRepository repository;
  final String recipeId;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    final recipe = repository.getRecipeById(recipeId);

    // Si la recette n'existe pas
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette introuvable')),
        body: const Center(
          child: Text('Cette recette n\'existe pas ou a été supprimé.'),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // En-tete retractable avec l'image de la recette
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
                ),
              ),
              background: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // Contenu Detaillle
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta Information: Categorie, duree, badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.category_outlined, size: 16),
                        label: Text(recipe.category),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.duration} min',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 12),
                          DifficultyBadge(level: recipe.difficulty),
                        ],
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  // Section Ingredients
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Divider(height: 32),

                  // Section Instructions
                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...recipe.instructions.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            child: Text(
                              '$index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              step,
                              style: const TextStyle(fontSize: 12, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
