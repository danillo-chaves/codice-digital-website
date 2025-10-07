import 'package:flutter/material.dart';
import 'package:codice_digital/controllers/home_controller.dart';

class HeroSection extends StatelessWidget {
  final HomeController controller;
  const HeroSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: controller.headline,
              builder: (_, headline, __) => Text(
                headline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: 24),
            ValueListenableBuilder<String>(
              valueListenable: controller.subHeadline,
              builder: (_, subHeadline, __) => Text(
                subHeadline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: controller.scrollToContact,
              child: const Text('SOLICITE UM ORÇAMENTO'),
            ),
          ],
        ),
      ),
    );
  }
}
