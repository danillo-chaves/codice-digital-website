// lib/views/home/widgets/plan_card.dart (VERSÃO COM EFEITO DE HOVER)

import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/models/plan_model.dart';
import 'package:flutter/material.dart';

// 1. Convertemos para StatefulWidget para guardar o estado de "hover"
class PlanCard extends StatefulWidget {
  final PlanModel plan;
  const PlanCard({super.key, required this.plan});

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  // 2. Variável de estado para saber se o mouse está em cima do card
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 3. Usamos InkWell para detectar o hover e dar um efeito de clique
    return InkWell(
      onTap: () {}, // Deixamos o onTap vazio por enquanto
      onHover: (isHovering) {
        // 4. Quando o estado de hover muda, atualizamos nossa variável
        setState(() {
          _isHovered = isHovering;
        });
      },
      borderRadius: BorderRadius.circular(
        12,
      ), // Arredonda a área do clique/hover
      child: AnimatedContainer(
        // 5. Trocamos Container por AnimatedContainer para animar as mudanças
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 320,
        padding: const EdgeInsets.symmetric(vertical: 24),
        // 6. A transformação (escala) agora depende do _isHovered
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        transformAlignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: widget.plan.isFeatured
              ? AppColors.white
              : AppColors.primaryDark,
          borderRadius: BorderRadius.circular(12),
          border: widget.plan.isFeatured
              ? null
              : Border.all(color: AppColors.mutedPurple),
          // 7. A sombra também muda com o hover
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColors.primaryAccent.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          children: [
            if (widget.plan.isFeatured)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
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
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.plan.title.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: widget.plan.isFeatured
                          ? AppColors.black
                          : AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.plan.price,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: widget.plan.isFeatured
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...widget.plan.features.map(
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
                                    color: widget.plan.isFeatured
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
                      backgroundColor: widget.plan.isFeatured
                          ? AppColors.black
                          : AppColors.primaryAccent,
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(widget.plan.buttonText.toUpperCase()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
