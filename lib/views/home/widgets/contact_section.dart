// lib/views/home/widgets/contact_section.dart
import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  final HomeController controller;
  const ContactSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ), // Limita a largura do formulário
          child: Form(
            key: controller
                .formKey, // Conecta o formulário à nossa chave no controller
            child: Column(
              children: [
                Text(
                  'Entre em Contato',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tem uma ideia ou projeto? Vamos conversar!',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Campo de Nome
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Seu nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Campo de E-mail
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(labelText: 'Seu e-mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu e-mail';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Por favor, digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Campo de Mensagem
                TextFormField(
                  controller: controller.messageController,
                  decoration: const InputDecoration(labelText: 'Sua mensagem'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite sua mensagem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),

                // Botão de Envio com indicador de "carregando"
                ValueListenableBuilder<bool>(
                  valueListenable: controller.isLoading,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : controller.submitContactForm,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('ENVIAR MENSAGEM'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
