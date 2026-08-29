class Recipe {
  final String id;
  final String title;
  final String category;
  final int duration;
  final List<String> ingredients;
  final List<String> instructions;
  final String imageUrl;
  final String difficulty;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
    required this.difficulty,
  });
}
