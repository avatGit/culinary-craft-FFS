#!/bin/bash

# Nom du dossier de base
LIB_DIR="lib"

echo "🚀 Génération de l'architecture pour CulinaryCraft..."

# 1. Core (Thème, constantes, helpers)
mkdir -p "$LIB_DIR/core/theme"
mkdir -p "$LIB_DIR/core/constants"

# 2. Data & Models (Structure des données et mock data)
mkdir -p "$LIB_DIR/data/models"
mkdir -p "$LIB_DIR/data/repositories"

# 3. Routing
mkdir -p "$LIB_DIR/routing"

# 4. Presentation (Écrans et Widgets réutilisables)
mkdir -p "$LIB_DIR/presentation/screens/dashboard"
mkdir -p "$LIB_DIR/presentation/screens/recipe_list"
mkdir -p "$LIB_DIR/presentation/screens/recipe_detail"
mkdir -p "$LIB_DIR/presentation/screens/add_recipe"
mkdir -p "$LIB_DIR/presentation/widgets"

# 5. Création des fichiers d'initialisation (squelettes)
touch "$LIB_DIR/core/theme/app_theme.dart"
touch "$LIB_DIR/data/models/recipe.dart"
touch "$LIB_DIR/data/repositories/recipe_repository.dart"
touch "$LIB_DIR/routing/app_router.dart"

# Fichiers de widgets réutilisables requis par le barème
touch "$LIB_DIR/presentation/widgets/recipe_card.dart"
touch "$LIB_DIR/presentation/widgets/custom_search_bar.dart"
touch "$LIB_DIR/presentation/widgets/custom_button.dart"

echo "✅ Arborescence créée avec succès !"