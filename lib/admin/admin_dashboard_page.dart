import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codice_digital/admin/edit_content_section.dart';
import 'package:codice_digital/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  final AdminController adminController = AdminController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Códice Digital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            tooltip: 'Ver Site',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              adminController.signOut();
            },
            tooltip: 'Sair',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.list_alt), text: 'Leads'),
            Tab(icon: Icon(Icons.edit), text: 'Editar Conteúdo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildLeadsList(),
          EditContentSection(controller: adminController),
        ],
      ),
    );
  }

  Widget _buildLeadsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: adminController.getContactsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum contato recebido ainda.',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        final contacts = snapshot.data!.docs;
        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            final data = contact.data() as Map<String, dynamic>;
            final timestamp = data['timestamp'] as Timestamp;
            final formattedDate = DateFormat(
              'dd/MM/yyyy HH:mm',
            ).format(timestamp.toDate());
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(data['name'] ?? 'Nome não informado'),
              subtitle: Text(data['email'] ?? 'E-mail não informado'),
              trailing: Text(formattedDate),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Mensagem de ${data['name']}'),
                    content: SingleChildScrollView(
                      child: Text(data['message'] ?? 'Nenhuma mensagem.'),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Fechar'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
