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
  bool _animateTitle = false;

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

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _animateTitle = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildTopAppBarContent() {
    return Stack(
      key: const ValueKey('LogoTitle'),
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/images/logo.png', height: 35),
        ),
        AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(left: _animateTitle ? 61.0 : 45.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: _animateTitle ? 1.0 : 0.0,
            child: const Text('Códice Digital'),
          ),
        ),
      ],
    );
  }

  Widget _buildScrolledAppBarContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        key: const ValueKey('LogoMenu'),
        children: [
          Image.asset('assets/images/logo.png', height: 35),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            tooltip: 'Acessar Painel Admin',
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              debugPrint('Menu clicado!');
            },
          ),
        ],
      ),
    );
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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isScrolled
                  ? _buildScrolledAppBarContent()
                  : _buildTopAppBarContent(),
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
