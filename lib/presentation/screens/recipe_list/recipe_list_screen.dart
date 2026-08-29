import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:culinary_craft/presentation/screens/recipe_detail/recipe_detail_screen.dart';
import 'package:culinary_craft/presentation/widgets/custom_search_bar.dart';
import 'package:culinary_craft/presentation/widgets/recipe_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/recipe.dart';

class RecipeListScreen extends StatefulWidget {
  // Utilisation de la classe abstraite RecipeRepository
  final RecipeRepository repository;

  const RecipeListScreen({super.key, required this.repository});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late List<Recipe> _allRecipes;
  List<Recipe> _filteredRecipes = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Chargement des recettes via la nouvelle méthode getAllRecipes()
    _allRecipes = widget.repository.getAllRecipes();
    _filteredRecipes = _allRecipes;
  }

  // Logique de firltrage
  void _filterRecipes(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRecipes = _allRecipes;
      } else {
        _filteredRecipes = _allRecipes.where((recipe) {
          final titleMatch = recipe.title.toLowerCase().contains(
            query.toLowerCase(),
          );
          final categoryMatch = recipe.category.toLowerCase().contains(
            query.toLowerCase(),
          );
          return titleMatch || categoryMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 600;

    return Scaffold(
      appBar: AppBar(title: const Text('CulinaryCraft')),

      body: Column(
        children: [
          // Barre de recherche reutilisable
          CustomSearchBar(
            onChanged: _filterRecipes,
            controller: _searchController,
          ),

          // Zone affichage des recettes (prend tout l'espace restante
          Expanded(
            child: _filteredRecipes.isEmpty
                ? const Center(child: Text('Aucune recette trouveeé.'))
                : isTablet
                ? GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.9,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: _filteredRecipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                        recipe: _filteredRecipes[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            context.push(
                                  '/recipe/${_filteredRecipes[index].id}',
                                )
                                as Route<Object?>,
                          );
                        },
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filteredRecipes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: RecipeCard(
                          recipe: _filteredRecipes[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              context.push(
                                    '/recipe/${_filteredRecipes[index].id}',
                                  )
                                  as Route<Object?>,
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add-recipe');
        },
        label: const Text('Rectte'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
