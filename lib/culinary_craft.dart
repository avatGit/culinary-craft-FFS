/// Fichier d'exportation central pour le projet CulinaryCraft.
library;

// Modèles de données
export 'package:culinary_craft/data/models/recipe.dart';

// Repositories
export 'package:culinary_craft/data/repositories/recipe_repository.dart';

// Écrans de l'application
export 'package:culinary_craft/presentation/screens/add_recipe/add_recipe_screen.dart';
export 'package:culinary_craft/presentation/screens/dashboard/dashboard_screen.dart';
export 'package:culinary_craft/presentation/screens/recipe_detail/recipe_detail_screen.dart';
export 'package:culinary_craft/presentation/screens/recipe_list/recipe_list_screen.dart';

// Widgets réutilisables
export 'package:culinary_craft/presentation/widgets/custom_button.dart';
export 'package:culinary_craft/presentation/widgets/custom_search_bar.dart';
export 'package:culinary_craft/presentation/widgets/difficulty_badge.dart';
export 'package:culinary_craft/presentation/widgets/recipe_card.dart';

// Thème et Style
export 'package:culinary_craft/presentation/theme/theme_controller.dart';
export 'package:culinary_craft/core/theme/app_theme.dart';

// Routage
export 'package:culinary_craft/routing/app_router.dart';
