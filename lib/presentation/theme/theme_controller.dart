import 'package:flutter/material.dart';

/// Contrôleur permettant de gérer dynamiquement le mode de thème (clair/sombre).
/// Utilise [ValueNotifier] pour notifier les abonnés lors du changement de thème.
class ThemeController extends ValueNotifier<ThemeMode> {
  // Constructeur initialisant le mode par défaut sur le système
  ThemeController(super.value);

  /// Change le mode de thème actuel.
  void setThemeMode(ThemeMode mode) {
    if (value == mode) return;
    value = mode;
  }

  /// Bascule entre le mode clair et le mode sombre.
  void toggleTheme() {
    if (value == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }

  /// Indique si le mode sombre est actuellement activé.
  bool get isDarkMode => value == ThemeMode.dark;
}
