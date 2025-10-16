import 'dart:async';
import 'dart:ui';
import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/controllers/home_controller.dart';
import 'package:codice_digital/views/home/widgets/contact_section.dart';
import 'package:codice_digital/views/home/widgets/hero_section.dart';
import 'package:codice_digital/views/home/widgets/plans_section.dart';
import 'package:codice_digital/views/home/widgets/services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolled = ValueNotifier(false);
  final ValueNotifier<bool> _animateTitleOnLoad = ValueNotifier(false);
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey plansKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  Timer? _timer;

  final ValueNotifier<Alignment> _blob1Alignment = ValueNotifier(
    Alignment.topLeft,
  );
  final ValueNotifier<Alignment> _blob2Alignment = ValueNotifier(
    Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        if (!_isScrolled.value) _isScrolled.value = true;
      } else {
        if (_isScrolled.value) _isScrolled.value = false;
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _animateTitleOnLoad.value = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        _blob1Alignment.value = _blob1Alignment.value == Alignment.topLeft
            ? Alignment.bottomRight
            : Alignment.topLeft;
        _blob2Alignment.value = _blob2Alignment.value == Alignment.bottomRight
            ? Alignment.topLeft
            : Alignment.bottomRight;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _isScrolled.dispose();
    _animateTitleOnLoad.dispose();
    _blob1Alignment.dispose();
    _blob2Alignment.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      if (Scaffold.of(context).isEndDrawerOpen) Navigator.of(context).pop();
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildTopAppBarContent(bool animateTitleValue) {
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
          padding: EdgeInsets.only(left: animateTitleValue ? 61.0 : 45.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: animateTitleValue ? 1.0 : 0.0,
            child: const Text('Códice Digital'),
          ),
        ),
      ],
    );
  }

  Widget _buildScrolledAppBarContent({required VoidCallback onMenuPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        key: const ValueKey('LogoMenu'),
        children: [
          Image.asset('assets/images/logo.png', height: 35),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/admin'),
            tooltip: 'Acessar Painel Admin',
          ),
          IconButton(icon: const Icon(Icons.menu), onPressed: onMenuPressed),
        ],
      ),
    );
  }

  Widget _buildAnimatedBlobs() {
    return ValueListenableBuilder<Alignment>(
      valueListenable: _blob1Alignment,
      builder: (context, blob1Align, _) {
        return ValueListenableBuilder<Alignment>(
          valueListenable: _blob2Alignment,
          builder: (context, blob2Align, _) {
            return Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: AnimatedAlign(
                    duration: const Duration(seconds: 10),
                    curve: Curves.easeInOut,
                    alignment: blob1Align,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryAccent.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                  child: AnimatedAlign(
                    duration: const Duration(seconds: 10),
                    curve: Curves.easeInOut,
                    alignment: blob2Align,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mutedPurple.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryAccent),
              child: Text(
                'Navegação',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.build_circle_outlined),
              title: const Text('Serviços'),
              onTap: () => _scrollToSection(servicesKey),
            ),
            ListTile(
              leading: const Icon(Icons.price_change_outlined),
              title: const Text('Planos'),
              onTap: () => _scrollToSection(plansKey),
            ),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: const Text('Contato'),
              onTap: () => _scrollToSection(contactKey),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 16),
        child: ValueListenableBuilder<bool>(
          valueListenable: _isScrolled,
          builder: (context, isScrolled, child) {
            return AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              scrolledUnderElevation: 0,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: isScrolled
                        ? AppColors.primaryDark.withOpacity(0.9)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: isScrolled
                          ? AppColors.mutedPurple.withOpacity(0.5)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _animateTitleOnLoad,
                    builder: (context, animateOnLoad, child) {
                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Image.asset('assets/images/logo.png', height: 35),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            left: isScrolled ? 10.0 : 45.0,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: isScrolled
                                  ? 0.0
                                  : (animateOnLoad ? 1.0 : 0.0),
                              child: const Text('Códice Digital'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: isScrolled ? 1.0 : 0.0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.admin_panel_settings_outlined,
                                    ),
                                    onPressed: isScrolled
                                        ? () => Navigator.pushNamed(
                                            context,
                                            '/admin',
                                          )
                                        : null,
                                    tooltip: 'Acessar Painel Admin',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.menu),
                                    onPressed: isScrolled
                                        ? () => scaffoldKey.currentState
                                              ?.openEndDrawer()
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _buildAnimatedBlobs(),
          ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              HeroSection(controller: _controller),
              ServicesSection(key: servicesKey, controller: _controller)
                  .animate()
                  .fade(duration: 600.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
              PlansSection(key: plansKey, controller: _controller)
                  .animate()
                  .fade(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
              ContactSection(key: contactKey, controller: _controller)
                  .animate()
                  .fade(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
            ],
          ),
        ],
      ),
    );
  }
}
