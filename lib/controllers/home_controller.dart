// lib/controllers/home_controller.dart (VERSÃO FINAL E COMPLETA)

import 'package:codice_digital/models/plan_model.dart';
import 'package:codice_digital/models/service_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  // DADOS PARA A HERO SECTION
  final ValueNotifier<String> headline = ValueNotifier<String>(
    'Códice Digital: Transformamos Ideias em Realidade Digital.',
  );
  final ValueNotifier<String> subHeadline = ValueNotifier<String>(
    'Desenvolvimento de software sob medida e otimização de presença online para alavancar seu negócio.',
  );

  // DADOS PARA A SEÇÃO DE SERVIÇOS
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

  // DADOS PARA A SEÇÃO DE PLANOS
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

  void scrollToContact() {
    debugPrint('Botão CTA clicado! Rolando para o contato...');
  }

  void dispose() {
    headline.dispose();
    subHeadline.dispose();
    services.dispose();
    plans.dispose();
  }
}
