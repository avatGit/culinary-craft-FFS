import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key, required RecipesRepository repository});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

//class _RecipeListScreenState extends State<RecipeListScreen> {
//final RecipesRepository _recipesRepository;

//}
