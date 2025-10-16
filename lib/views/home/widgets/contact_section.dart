import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:codice_digital/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  ContactSection({super.key, required this.controller});
  final HomeController controller;

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.mutedPurple),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.mutedPurple, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
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

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.mutedPurple.withOpacity(0.5),
                ),
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: _buildInputDecoration('Seu nome'),
                      validator: (v) =>
                          v!.isEmpty ? 'Por favor, digite seu nome' : null,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: _buildInputDecoration('Seu e-mail'),
                      validator: (v) {
                        if (v!.isEmpty) return 'Por favor, digite seu e-mail';
                        if (!v.contains('@') || !v.contains('.'))
                          return 'Por favor, digite um e-mail válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: controller.phoneController,
                      decoration: _buildInputDecoration(
                        'Seu telefone (Opcional)',
                      ),
                      keyboardType:
                          TextInputType.phone, // Define o teclado numérico
                      // Não vamos adicionar um validador para que o campo seja opcional
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: controller.messageController,
                      decoration: _buildInputDecoration('Sua mensagem'),
                      maxLines: 4,
                      validator: (v) =>
                          v!.isEmpty ? 'Por favor, digite sua mensagem' : null,
                    ),
                    const SizedBox(height: 32),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.isLoading,
                      builder: (context, isLoading, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final success = await controller
                                      .submitContactForm();

                                  if (!context.mounted) return;

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Mensagem enviada com sucesso! Em breve um de nossos consultores entrará em contato.',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Ocorreu um erro. Verifique os campos e tente novamente.',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('ENVIAR MENSAGEM'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
