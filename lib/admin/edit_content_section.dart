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
  bool _isLoading = true;
  bool _isSaving = false;

  // Controladores para Seção Hero
  final _headlineController = TextEditingController();
  final _subheadlineController = TextEditingController();

  // Controladores para Seção de Serviços
  final _service1TitleController = TextEditingController();
  final _service1DescController = TextEditingController();
  final _service1IconController = TextEditingController();
  final _service2TitleController = TextEditingController();
  final _service2DescController = TextEditingController();
  final _service2IconController = TextEditingController();

  // Guarda a lista de planos
  List<dynamic> _plans = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final data = await widget.controller.loadPageContent();
    if (data != null && mounted) {
      _headlineController.text = data['heroHeadline'] ?? '';
      _subheadlineController.text = data['heroSubheadline'] ?? '';

      if (data['services'] is List && (data['services'] as List).length >= 2) {
        final services = data['services'] as List;
        _service1IconController.text = services[0]['icon'] ?? 'help';
        _service1TitleController.text = services[0]['title'] ?? '';
        _service1DescController.text = services[0]['description'] ?? '';
        _service2IconController.text = services[1]['icon'] ?? 'help';
        _service2TitleController.text = services[1]['title'] ?? '';
        _service2DescController.text = services[1]['description'] ?? '';
      }

      if (data['plans'] is List) {
        _plans = List<dynamic>.from(data['plans'] as List);
      }

      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveContent() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      final dataToSave = {
        'heroHeadline': _headlineController.text,
        'heroSubheadline': _subheadlineController.text,
        'services': [
          {
            'icon': _service1IconController.text,
            'title': _service1TitleController.text,
            'description': _service1DescController.text,
          },
          {
            'icon': _service2IconController.text,
            'title': _service2TitleController.text,
            'description': _service2DescController.text,
          },
        ],
        'plans': _plans,
      };

      final success = await widget.controller.savePageContent(
        dataToSave: dataToSave,
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
    _service1TitleController.dispose();
    _service1DescController.dispose();
    _service1IconController.dispose();
    _service2TitleController.dispose();
    _service2DescController.dispose();
    _service2IconController.dispose();
    super.dispose();
  }

  void _showPlanDialog({Map<String, dynamic>? planData, int? index}) {
    final isEditing = planData != null;
    final dialogFormKey = GlobalKey<FormState>();

    final titleController = TextEditingController(
      text: isEditing ? planData['title'] : '',
    );
    final priceController = TextEditingController(
      text: isEditing ? planData['price'] : '',
    );
    final featuresController = TextEditingController(
      text: isEditing ? (planData['features'] as List).join('\n') : '',
    );
    final buttonTextController = TextEditingController(
      text: isEditing ? planData['buttonText'] : '',
    );
    bool isFeatured = isEditing ? planData['isFeatured'] : false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Editar Plano' : 'Adicionar Novo Plano'),
              content: Form(
                key: dialogFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Título'),
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                      TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Preço (Ex: R\$490\\n(Pagamento Único))',
                        ),
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                      TextFormField(
                        controller: featuresController,
                        decoration: const InputDecoration(
                          labelText: 'Funcionalidades (uma por linha)',
                        ),
                        maxLines: 5,
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                      TextFormField(
                        controller: buttonTextController,
                        decoration: const InputDecoration(
                          labelText: 'Texto do Botão',
                        ),
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                      SwitchListTile(
                        title: const Text('Plano em Destaque?'),
                        value: isFeatured,
                        onChanged: (value) =>
                            setDialogState(() => isFeatured = value),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FilledButton(
                  child: const Text('Salvar'),
                  onPressed: () {
                    if (dialogFormKey.currentState!.validate()) {
                      final newPlanData = {
                        'title': titleController.text,
                        'price': priceController.text,
                        'features': featuresController.text
                            .split('\n')
                            .where((s) => s.isNotEmpty)
                            .toList(),
                        'buttonText': buttonTextController.text,
                        'isFeatured': isFeatured,
                      };
                      setState(() {
                        if (isEditing) {
                          _plans[index!] = newPlanData;
                        } else {
                          _plans.add(newPlanData);
                        }
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text(
          'Você tem certeza que deseja excluir este plano? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir'),
            onPressed: () {
              setState(() => _plans.removeAt(index));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlanTile(Map<String, dynamic> planData, int index) {
    return ExpansionTile(
      leading: Icon(
        planData['isFeatured'] == true ? Icons.star : Icons.label_outline,
      ),
      title: Text(planData['title'] ?? 'Plano sem título'),
      subtitle: Text(
        planData['price']?.replaceAll('\\n', ' ') ?? 'Preço não definido',
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Funcionalidades:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              if (planData['features'] is List)
                for (var feature in (planData['features'] as List))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('• $feature'),
                  ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                    onPressed: () =>
                        _showPlanDialog(planData: planData, index: index),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Excluir',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => _showDeleteConfirmation(index),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
                    labelText: 'Título Principal',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subheadlineController,
                  decoration: const InputDecoration(
                    labelText: 'Subtítulo',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const Divider(height: 64),
                Text(
                  'Seção de Serviços',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  'Primeiro Serviço',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _service1TitleController,
                  decoration: const InputDecoration(
                    labelText: 'Título do Serviço 1',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _service1IconController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Ícone 1 (ex: code)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _service1DescController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição do Serviço 1',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const SizedBox(height: 24),
                Text(
                  'Segundo Serviço',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _service2TitleController,
                  decoration: const InputDecoration(
                    labelText: 'Título do Serviço 2',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _service2IconController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Ícone 2 (ex: trending_up)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _service2DescController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição do Serviço 2',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (v) => v!.isEmpty ? 'Campo obrigatório.' : null,
                ),
                const Divider(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seção de Planos',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    FilledButton.tonalIcon(
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar Plano'),
                      onPressed: () => _showPlanDialog(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_plans.isEmpty)
                  const Text('Nenhum plano cadastrado.')
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _plans.length,
                    itemBuilder: (context, index) {
                      final plan = _plans[index] as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: _buildPlanTile(plan, index),
                      );
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
