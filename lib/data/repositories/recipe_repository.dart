import 'package:culinary_craft/data/models/recipe.dart';

class RecipesRepository {
  // List modifiable en memoire. Simule la base de donnee
  final List<Recipe> _recipes = [
    Recipe(
      id: "1",
      title: "Pasta Carbonara",
      category: "Italian",
      duration: 30,
      ingredients: ["pasta", "eggs", "bacon", "parmesan"],
      instructions: ["Cook pasta", "Fry bacon", "Mix eggs and cheese"],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvZ4Y4OejzECC2hsQFZVIMUtNZ_VGjffc-5fJEsqKi5ImNpHMiGDzES_LpdkCh1VmT0GzkmHwUq1mN-w1cO3FLcdyJsZ4NnrDntR1nRKhyqA&s=10",
      difficulty: "Medium",
    ),
    Recipe(
      id: "2",
      title: "Chicken Curry",
      category: "Indian",
      duration: 45,
      ingredients: ["chicken", "coconut milk", "curry powder", "onion"],
      instructions: [
        "Chop the onion",
        "Cook the chicken",
        "Add spices and coconut milk",
      ],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKNP3Fv_SScf71c8qZKp40CBkkv08fGq65ZNPHggWp8O6v9SiLFyIIgZ-9&s=10",
      difficulty: "Medium",
    ),
    Recipe(
      id: "3",
      title: "Greek Salad",
      category: "Greek",
      duration: 15,
      ingredients: ["tomatoes", "cucumber", "feta", "olives"],
      instructions: [
        "Chop the vegetables",
        "Add feta and olives",
        "Season and toss",
      ],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWLQGXhZSPBKS9mthqd70IoOdbMd1DOzBcShnn7hxaRPfG78cg8a6J-TS2yJeOIJoWqnUIRwzDTdBeU032V2Qz0BkrVwLCPy5TJEk8bZhisA&s=10",
      difficulty: "Easy",
    ),
    Recipe(
      id: "4",
      title: "Beef Tacos",
      category: "Mexican",
      duration: 25,
      ingredients: ["ground beef", "taco shells", "lettuce", "cheddar"],
      instructions: [
        "Cook the beef",
        "Warm the taco shells",
        "Fill and garnish the tacos",
      ],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJK8scSeONiOAFZVuMZOF9r7tGp1XXIIehbSPhfEW-Wg&s=10",
      difficulty: "Easy",
    ),
    Recipe(
      id: "5",
      title: "Mushroom Risotto",
      category: "Italian",
      duration: 40,
      ingredients: ["arborio rice", "mushrooms", "vegetable stock", "parmesan"],
      instructions: [
        "Saute the mushrooms",
        "Toast the rice",
        "Gradually add stock and stir",
      ],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9eRlqZCaOpg9hFU8WoMCmfG9prLV1MFqzgjZQcqpM8g&s=10",
      difficulty: "Hard",
    ),
    Recipe(
      id: "6",
      title: "Apple Pancakes",
      category: "Breakfast",
      duration: 20,
      ingredients: ["flour", "apples", "milk", "eggs"],
      instructions: [
        "Prepare the batter",
        "Fold in grated apples",
        "Cook the pancakes",
      ],
      imageUrl:
          "data:image/jpeg;base64,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",
      difficulty: "Easy",
    ),
  ];

  // Recuperer toutes les recettes
  List<Recipe> getAllRecipe() {
    return List.unmodifiable(_recipes);
  }

  Recipe? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (_) {
      return null;
    }
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }
}
