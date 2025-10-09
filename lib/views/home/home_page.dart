// lib/views/home/home_page.dart (VERSÃO COM ANIMAÇÃO "ESCONDER ATRÁS DO LOGO")

import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/controllers/home_controller.dart';
import 'package:codice_digital/views/home/widgets/contact_section.dart';
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
  final ScrollController _scrollController = ScrollController();

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        if (mounted && !_isScrolled) {
          setState(() => _isScrolled = true);
        }
      } else {
        if (mounted && _isScrolled) {
          setState(() => _isScrolled = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: _isScrolled
                  ? AppColors.primaryDark.withOpacity(0.9)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: _isScrolled
                    ? AppColors.mutedPurple.withOpacity(0.5)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // 1. Usamos um Stack para sobrepor o logo e o texto
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // O contêiner do texto
                    AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      // Se rolou a tela, o padding esquerdo diminui, movendo o texto para "trás" do logo
                      padding: EdgeInsets.only(left: _isScrolled ? 16.0 : 61.0),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        // Se rolou a tela, o texto fica invisível
                        opacity: _isScrolled ? 0.0 : 1.0,
                        child: const Text('Códice Digital'),
                      ),
                    ),
                    // O logo fica por cima de tudo no Stack
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Image.asset(
                        'assets/images/logo.png', // Verifique o nome do seu logo
                        height: 35,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // O menu continua com a mesma animação de opacidade
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isScrolled ? 1.0 : 0.0,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: _isScrolled
                        ? () => debugPrint('Menu clicado!')
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          HeroSection(controller: _controller),
          ServicesSection(controller: _controller),
          PlansSection(controller: _controller),
          ContactSection(controller: _controller),
        ],
      ),
    );
  }
}
