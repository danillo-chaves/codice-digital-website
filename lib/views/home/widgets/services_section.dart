import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  final HomeController controller;
  const ServicesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        children: [
          Text(
            'Nossos Serviços',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 48),
          ValueListenableBuilder(
            valueListenable: controller.services,
            builder: (context, serviceList, _) {
              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: serviceList
                    .map((service) => _buildServiceCard(context, service))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, dynamic service) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(service.icon, color: AppColors.primaryAccent, size: 48),
          const SizedBox(height: 16),
          Text(
            service.title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 8),
          Text(
            service.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
