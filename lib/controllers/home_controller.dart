import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codice_digital/models/contact_model.dart';
import 'package:codice_digital/models/plan_model.dart';
import 'package:codice_digital/models/service_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // DADOS DA HERO SECTION (agora vêm do Firestore)
  final ValueNotifier<String> headline = ValueNotifier<String>('Carregando...');
  final ValueNotifier<String> subHeadline = ValueNotifier<String>('');

  // DADOS DA SEÇÃO DE SERVIÇOS (continuam fixos no código)
  final ValueNotifier<List<ServiceModel>>
  services = ValueNotifier<List<ServiceModel>>([
    ServiceModel(
      icon: Icons.code,
      title: 'Desenvolvimento de Software',
      description:
          'Criamos soluções personalizadas, de sites institucionais a sistemas complexos, para atender exatamente às suas necessidades.',
    ),
    ServiceModel(
      icon: Icons.trending_up,
      title: 'Otimização de Perfis Google',
      description:
          'Colocamos seu negócio no mapa. Otimizamos seu perfil no Google Meu Negócio para atrair mais clientes locais.',
    ),
  ]);

  // DADOS DA SEÇÃO DE PLANOS (continuam fixos no código)
  final ValueNotifier<List<PlanModel>> plans = ValueNotifier<List<PlanModel>>([
    PlanModel(
      title: 'Fundação Digital',
      price: 'R\$490\n(Pagamento Único)',
      features: [
        'Otimização Completa GMN',
        'Pesquisa de Palavras-Chave',
        'Otimização de Conteúdo',
        'Imagens Otimizadas para Google',
        'Link Direto para Avaliações',
        'Guia de 5 Estrelas',
      ],
      buttonText: 'Começar Agora',
    ),
    PlanModel(
      title: 'Plataforma de Aquisição',
      price: 'R\$1190\n(Pagamento Único)',
      features: [
        'TUDO do Fundação Digital',
        'Site de Página Única',
        'Foco em Geração de Contatos',
        'SEO On-Page Avançado',
        'Certificado SSL de Segurança',
      ],
      buttonText: 'Otimizar Meu Negócio',
      isFeatured: true,
    ),
    PlanModel(
      title: 'Ecossistema Digital',
      price: 'R\$2390\n(Pagamento Único)',
      features: [
        'TUDO da Plataforma de Aquisição',
        'Site Institucional Completo',
        'Páginas Dedicadas para Serviços',
        'Estrutura de Blog Profissional',
        'Treinamento de Publicação no Blog',
        'Consultoria Estratégica',
      ],
      buttonText: 'Liderar Mercado',
    ),
  ]);

  // LÓGICA DO FORMULÁRIO DE CONTATO
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // CONSTRUTOR DA CLASSE
  HomeController() {
    _fetchLandingPageContent();
  }

  // MÉTODO PARA BUSCAR CONTEÚDO DO FIRESTORE
  Future<void> _fetchLandingPageContent() async {
    try {
      final doc = await _firestore
          .collection('site_content')
          .doc('landing_page')
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        headline.value = data['heroHeadline'] ?? 'Título não encontrado';
        subHeadline.value =
            data['heroSubheadline'] ?? 'Subtítulo não encontrado';
      }
    } catch (e) {
      debugPrint("Erro ao buscar conteúdo da landing page: $e");
      headline.value = 'Erro ao carregar o título';
    }
  }

  // MÉTODO PARA O BOTÃO DA HERO SECTION
  void scrollToContact() {
    debugPrint('Botão CTA clicado! Rolando para o contato...');
  }

  // MÉTODO PARA ENVIAR FORMULÁRIO DE CONTATO
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

  // MÉTODO PARA LIMPAR A MEMÓRIA
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
