import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/models/plan_model.dart';
import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final PlanModel plan;
  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: plan.isFeatured ? AppColors.white : AppColors.primaryDark,
        borderRadius: BorderRadius.circular(12),
        border: plan.isFeatured
            ? null
            : Border.all(color: AppColors.mutedPurple),
      ),
      child: Column(
        children: [
          // Widget para a tag "MAIS ESCOLHIDO"
          if (plan.isFeatured)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'MAIS ESCOLHIDO',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

          // Padding para o conteúdo principal do card
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: plan.isFeatured ? AppColors.black : AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  plan.price,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: plan.isFeatured ? AppColors.black : AppColors.white,
                  ),
                ),
                const SizedBox(height: 24),
                // Mapeia a lista de funcionalidades para criar os widgets de texto
                ...plan.features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: AppColors.primaryAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: plan.isFeatured
                                      ? AppColors.mutedPurple
                                      : AppColors.lightGray,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAccent,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(plan.buttonText.toUpperCase()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
