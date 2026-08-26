import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';

class AddRecipeScreen extends StatelessWidget {
  final RecipesRepository repository;

  const AddRecipeScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une nouvelle recette')),
    );
  }
}
