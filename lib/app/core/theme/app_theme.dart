// lib/app/core/theme/app_theme.dart
import 'package:flutter/material.dart';

// Definindo nossas cores para fácil acesso
class AppColors {
  static const Color primaryDark = Color(0xFF150E2B);
  static const Color primaryAccent = Color(0xFF7824F6);
  static const Color mutedPurple = Color(0xFF665C8B);
  static const Color lightGray = Color(0xFFC8C8C8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}

// Criando nosso tema escuro
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.primaryDark,
  primaryColor: AppColors.primaryAccent,
  fontFamily: 'Roboto', // Mantendo a fonte
  // Tema da AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryDark,
    elevation: 0,
  ),

  // Tema dos textos
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(color: AppColors.lightGray),
    bodyMedium: TextStyle(color: AppColors.mutedPurple), // Para descrições
  ),

  // Tema dos botões
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryAccent,
      foregroundColor: AppColors.white, // Cor do texto do botão
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bordas levemente arredondadas
      ),
    ),
  ),
);
