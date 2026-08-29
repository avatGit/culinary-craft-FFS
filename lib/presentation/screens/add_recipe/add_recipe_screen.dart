import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';

import '../../../data/models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  // Référence au repository via son interface abstraite
  final RecipeRepository repository;

  const AddRecipeScreen({super.key, required this.repository});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _durationController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  String _selectedDifficulty = 'Facile';
  final List<String> _difficulties = ['Facile', 'Moyen', 'Difficile'];

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
    _durationController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Decoupage des elements separes par des virgules ou retours a la ligne
      final ingredients = _ingredientsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      final instructions = _instructionsController.text
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final newRecipe = Recipe(
        // Génération d'un ID unique plus robuste basé sur les microsecondes
        id: 'recipe_${DateTime.now().microsecondsSinceEpoch}',
        title: _titleController.text.trim(),
        category: _categoryController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        duration: int.parse(_durationController.text.trim()),
        difficulty: _selectedDifficulty,
        ingredients: ingredients,
        instructions: instructions,
      );

      widget.repository.addRecipe(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recette ajouté avec succes !')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle recette')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Titre
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre de la recette',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Entrez un titre'
                    : null,
              ),
              const SizedBox(height: 16),

              // Categorie et duree / sur la meme ligne
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Categorie',
                        hintText: 'ex: Plat, Dessert',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Requis' : null,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: TextFormField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Duree (min)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Requis';
                        if (int.tryParse(val.trim()) == null) {
                          return 'Nombre valide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // URL image
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: "URL de l'image",
                  hintText: 'https://...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Entrez une URL d\'image valide'
                    : null,
              ),
              const SizedBox(height: 16),

              // Difficulte (Dropdown)
              DropdownButtonFormField<String>(
                initialValue: _selectedDifficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficulte',
                  border: OutlineInputBorder(),
                ),
                items: _difficulties.map((dif) {
                  return DropdownMenuItem(value: dif, child: Text(dif));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedDifficulty = val);
                },
              ),
              const SizedBox(height: 16),

              // Ingrédients
              TextFormField(
                controller: _ingredientsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Ingrédients (séparés par des virgules)',
                  hintText: '2 oignons, 500g poulet, 1 pincée de sel',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Entrez des ingrédients'
                    : null,
              ),
              const SizedBox(height: 16),

              // Instructions
              TextFormField(
                controller: _instructionsController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Instructions (une étape par ligne)',
                  hintText:
                      'Couper le poulet\nFaire revenir les oignons\nLaisser mijoter',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Entrez les instructions'
                    : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                label: const Text('Enregistrer la recette'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
