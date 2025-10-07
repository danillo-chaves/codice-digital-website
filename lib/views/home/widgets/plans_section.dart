// lib/views/home/widgets/plans_section.dart

import 'package:codice_digital/controllers/home_controller.dart';
import 'package:codice_digital/views/home/widgets/plan_card.dart';
import 'package:flutter/material.dart';

class PlansSection extends StatelessWidget {
  final HomeController controller;
  const PlansSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        children: [
          Text(
            'Códice Digital: Soluções para Sua Presença Online',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 48),
          ValueListenableBuilder(
            valueListenable: controller.plans,
            builder: (_, plansList, __) {
              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: plansList
                    .map((plan) => PlanCard(plan: plan))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
