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
      imageUrl: "https://example.com/pasta_carbonara.jpg",
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
      imageUrl: "https://example.com/chicken_curry.jpg",
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
      imageUrl: "https://example.com/greek_salad.jpg",
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
      imageUrl: "https://example.com/beef_tacos.jpg",
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
      imageUrl: "https://example.com/mushroom_risotto.jpg",
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
      imageUrl: "https://example.com/apple_pancakes.jpg",
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
