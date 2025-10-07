// lib/app/app_widget.dart
import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/views/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Códice Digital',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      // Esta linha agora está correta, pois o construtor de HomePage é 'const'
      home: const HomePage(),
    );
  }
}
