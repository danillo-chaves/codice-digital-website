// lib/app/app_widget.dart (VERSÃO COM ROTAS)

import 'package:codice_digital/app/auth_check.dart';
import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/views/home/home_page.dart'; // Importe a HomePage
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Códice Digital',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,

      // 1. Dizemos qual rota é a inicial
      initialRoute: '/',

      // 2. Criamos um "mapa" de URLs para o nosso app
      routes: {
        // Quando o usuário acessar a raiz do site (ex: www.seusite.com/)
        // mostre a Landing Page.
        '/': (context) => const HomePage(),

        // Quando o usuário acessar www.seusite.com/admin
        // mostre o nosso "porteiro" AuthCheck, que decidirá entre
        // a tela de login ou o dashboard do admin.
        '/admin': (context) => const AuthCheck(),
      },
    );
  }
}
