// lib/models/plan_model.dart

class PlanModel {
  final String title;
  final String price;
  final List<String> features;
  final bool isFeatured;
  final String buttonText; // Campo obrigatório

  PlanModel({
    required this.title,
    required this.price,
    required this.features,
    required this.buttonText, // Precisa estar no construtor
    this.isFeatured = false,
  });
}
