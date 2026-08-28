import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DifficultyBadge extends StatelessWidget {
  final String level;

  const DifficultyBadge({super.key, required this.level});

  Color _getBadgeColor(String level) {
    return switch (level.toLowerCase()) {
      'facile' => Colors.green,
      'moyen' => Colors.orange,
      'difficile' => Colors.red,
      _ => Colors.grey,
    };
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: _getBadgeColor(level)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        capitalize(level),
        style: TextStyle(
          color: _getBadgeColor(level),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
