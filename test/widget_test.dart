import 'package:flutter_test/flutter_test.dart';
import 'package:culinary_craft/main.dart';
import 'package:culinary_craft/data/repositories/recipe_repository.dart';
import 'package:culinary_craft/routing/app_router.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final repository = RecipeRepositoryImpl();
    final router = AppRouter(repository);
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(appRouter: router));

    // Verify that we are on the dashboard
    expect(find.text('Tableau de bord'), findsOneWidget);
  });
}
