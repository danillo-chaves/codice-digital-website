// lib/views/home/home_page.dart (VERSÃO FINAL E COMPLETA)

import 'package:codice_digital/controllers/home_controller.dart';
import 'package:codice_digital/views/home/widgets/hero_section.dart';
import 'package:codice_digital/views/home/widgets/plans_section.dart';
import 'package:codice_digital/views/home/widgets/services_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Códice Digital')),
      body: ListView(
        children: [
          HeroSection(controller: _controller),
          ServicesSection(controller: _controller),
          PlansSection(controller: _controller),
        ],
      ),
    );
  }
}
