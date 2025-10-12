import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codice_digital/models/contact_model.dart';
import 'package:codice_digital/models/plan_model.dart';
import 'package:codice_digital/models/service_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Notificadores de conteúdo agora começam todos vazios
  final ValueNotifier<String> headline = ValueNotifier<String>('Carregando...');
  final ValueNotifier<String> subHeadline = ValueNotifier<String>('');
  final ValueNotifier<List<ServiceModel>> services =
      ValueNotifier<List<ServiceModel>>([]);
  final ValueNotifier<List<PlanModel>> plans = ValueNotifier<List<PlanModel>>(
    [],
  );

  // Lógica do formulário de contato
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Construtor da classe
  HomeController() {
    _fetchLandingPageContent();
  }

  // Método para "traduzir" o nome do ícone para um IconData
  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code;
      case 'trending_up':
        return Icons.trending_up;
      default:
        return Icons.help; // Ícone padrão caso não encontre
    }
  }

  // Método para buscar TODOS os dados do Firestore
  Future<void> _fetchLandingPageContent() async {
    try {
      final doc = await _firestore
          .collection('site_content')
          .doc('landing_page')
          .get();
      if (doc.exists) {
        final data = doc.data()!;

        // Carrega Hero Section
        headline.value = data['heroHeadline'] ?? 'Título não encontrado';
        subHeadline.value =
            data['heroSubheadline'] ?? 'Subtítulo não encontrado';

        // Carrega Services Section
        if (data['services'] is List) {
          final servicesData = data['services'] as List;
          services.value = servicesData
              .map(
                (serviceMap) => ServiceModel(
                  icon: _getIconFromString(serviceMap['icon']),
                  title: serviceMap['title'],
                  description: serviceMap['description'],
                ),
              )
              .toList();
        }

        // Carrega Plans Section
        if (data['plans'] is List) {
          final plansData = data['plans'] as List;
          plans.value = plansData
              .map(
                (planMap) => PlanModel(
                  title: planMap['title'],
                  price: planMap['price'],
                  features: List<String>.from(
                    planMap['features'],
                  ), // Converte a lista de features
                  buttonText: planMap['buttonText'],
                  isFeatured: planMap['isFeatured'],
                ),
              )
              .toList();
        }
      }
    } catch (e) {
      debugPrint("Erro ao buscar conteúdo da landing page: $e");
    }
  }

  // Método para o botão da Hero Section
  void scrollToContact() {
    debugPrint('Botão CTA clicado! Rolando para o contato...');
  }

  // Método para enviar formulário de contato
  Future<void> submitContactForm() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final contact = ContactModel(
        name: nameController.text,
        email: emailController.text,
        message: messageController.text,
        timestamp: Timestamp.now(),
      );

      try {
        await _firestore.collection('contacts').add(contact.toMap());
        nameController.clear();
        emailController.clear();
        messageController.clear();
        debugPrint('Contato salvo com sucesso!');
      } catch (e) {
        debugPrint('Erro ao salvar contato: $e');
      }
      isLoading.value = false;
    }
  }

  // Método para limpar a memória
  void dispose() {
    headline.dispose();
    subHeadline.dispose();
    services.dispose();
    plans.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    isLoading.dispose();
  }
}
