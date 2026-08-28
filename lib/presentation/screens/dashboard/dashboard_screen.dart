import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/recipe.dart';
import '../../widgets/recipe_card.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tableau de bord',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // SingleChildScrollView permet à l'ensemble de la page de défiler sur petits écrans
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1 : TITRE & GRILLE STATISTIQUE (KPI) ---
            Text(
              'Apercu Global',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // LayoutBuilder permet de lire les contraintes de taille de l'écran parent
            // pour rendre la grille responsive (Mobile vs Tablette)
            LayoutBuilder(
              builder: (context, constraints) {
                // Si la largeur depasse 600px, on passe a 4 columns, sinon 2
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

                return GridView.count(
                  // /!\ TRÈS IMPORTANT EN FLUTTER :
                  // shrinkWrap: true oblige le GridView à n'occuper QUE la hauteur exacte de ses enfants.
                  shrinkWrap: true,
                  // Pour éviter un conflit de défilement entre le SingleChildScrollView global et la grille.
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.35,
                  // Rapport Largeur / Hauteur des cartes
                  children: [
                    _KpiCard(
                      title: 'Recettes',
                      value: '$totalRecipes',
                      color: Colors.orange,
                      icon: Icons.restaurant_menu,
                    ),
                    _KpiCard(
                      title: 'Categorie',
                      value: '$categoriesCount',
                      color: Colors.blue,
                      icon: Icons.category,
                    ),
                    _KpiCard(
                      title: 'Temps Moyen',
                      value: '${avgDuration.round()} min',
                      color: Colors.green,
                      icon: Icons.timer,
                    ),
                    _KpiCard(
                      title: 'Faciles',
                      value: '$easyRecipesCount',
                      color: Colors.purple,
                      icon: Icons.sentiment_satisfied_alt,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // --- SECTION 2 : DERNIERE RECETTE AJOUTEE
            if (latestRecipe != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Derniere nouveauté',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/recipes');
                    },
                    child: const Text('Voir Tout'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Réutilisation de notre RecipeCard personnalisée
              RecipeCard(
                recipe: latestRecipe,
                onTap: () {
                  // Navigation vers les détails de cette recette
                  context.push(
                    '/recipe-detail',
                    //arguments: latestRecipe.id,
                  );
                },
              ),
            ],

            const SizedBox(height: 28),

            // --- SECTION 3 : ACTIONS RAPIDES ---
            Text(
              'Actions Rapides',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'Toutes les recettes',
                    icon: Icons.search,
                    // Utilisation des couleurs sémantiques de Material 3 (s'adapte au mode nuit)
                    color: Theme.of(context).colorScheme.primaryContainer,
                    textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    onTap: () => context.push('/recipes'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    label: 'Créer une recette',
                    icon: Icons.add,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    textColor: Theme.of(
                      context,
                    ).colorScheme.onSecondaryContainer,
                    onTap: () => context.push('/add-recipe'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// WIDGETS PRIVÉS COMPLEMENTAIRES
// =============================================================================

// Carte d'Indicateur Cle de Performance (KPI)
class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pastille circulaire pour l'icone
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bouton d'action grand format
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, size: 28, color: textColor),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
