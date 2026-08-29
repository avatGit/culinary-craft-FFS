import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culinary_craft/presentation/widgets/difficulty_badge.dart';

void main() {
  group('DifficultyBadge Widget Tests', () {
    testWidgets('doit afficher le texte avec une majuscule', (WidgetTester tester) async {
      // Construction du widget dans l'environnement de test
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DifficultyBadge(level: 'facile'),
          ),
        ),
      );

      // Vérification que le texte "Facile" est présent (majuscule appliquée par le widget)
      expect(find.text('Facile'), findsOneWidget);
    });

    testWidgets('doit appliquer la couleur verte pour le niveau facile', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DifficultyBadge(level: 'facile'),
          ),
        ),
      );

      // On récupère le widget Text à l'intérieur du badge
      final textWidget = tester.widget<Text>(find.text('Facile'));
      
      // La couleur du texte doit être Colors.green (défini dans _getBadgeColor)
      expect(textWidget.style?.color, Colors.green);
    });

    testWidgets('doit appliquer la couleur rouge pour le niveau difficile', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DifficultyBadge(level: 'difficile'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Difficile'));
      expect(textWidget.style?.color, Colors.red);
    });
  });
}
