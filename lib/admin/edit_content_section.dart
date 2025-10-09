import 'package:codice_digital/controllers/admin_controller.dart';
import 'package:flutter/material.dart';

class EditContentSection extends StatefulWidget {
  final AdminController controller;
  const EditContentSection({super.key, required this.controller});

  @override
  State<EditContentSection> createState() => _EditContentSectionState();
}

class _EditContentSectionState extends State<EditContentSection> {
  final _formKey = GlobalKey<FormState>();
  final _headlineController = TextEditingController();
  final _subheadlineController = TextEditingController();
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final data = await widget.controller.loadHeroSectionContent();
    if (data != null) {
      _headlineController.text = data['heroHeadline'] ?? '';
      _subheadlineController.text = data['heroSubheadline'] ?? '';
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveContent() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);
      final success = await widget.controller.saveHeroSectionContent(
        headline: _headlineController.text,
        subheadline: _subheadlineController.text,
      );
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Conteúdo salvo com sucesso!' : 'Erro ao salvar.',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _subheadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Editar Conteúdo da Landing Page',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                Text(
                  'Seção Hero',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _headlineController,
                  decoration: const InputDecoration(
                    labelText: 'Título Principal (Headline)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O título principal não pode ser vazio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subheadlineController,
                  decoration: const InputDecoration(
                    labelText: 'Subtítulo (Subheadline)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O subtítulo não pode ser vazio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: _isSaving ? null : _saveContent,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('SALVAR ALTERAÇÕES'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
