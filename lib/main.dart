import 'package:culinary_craft/data/repositories/recipe_repository.dart';

import 'package:culinary_craft/routing/app_router.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  final recipeRepository = RecipesRepository();
  final appRouter = AppRouter(recipeRepository);
  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CulinaryCraft',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.router,
    );
  }
}
