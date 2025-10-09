import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- MÉTODOS DE AUTENTICAÇÃO E LEADS ---

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // ... (código de login existente)
  }

  Future<void> signOut() async {
    // ... (código de logout existente)
  }

  Stream<QuerySnapshot> getContactsStream() {
    return _firestore
        .collection('contacts')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // --- NOVOS MÉTODOS PARA GERENCIAMENTO DE CONTEÚDO ---

  // Método para carregar os textos atuais do Firestore
  Future<Map<String, dynamic>?> loadHeroSectionContent() async {
    try {
      final doc = await _firestore
          .collection('site_content')
          .doc('landing_page')
          .get();
      if (doc.exists) {
        debugPrint('Conteúdo da Hero Section carregado.');
        return doc.data();
      }
    } catch (e) {
      debugPrint('Erro ao carregar conteúdo da Hero Section: $e');
    }
    return null;
  }

  // Método para salvar as alterações de volta no Firestore
  Future<bool> saveHeroSectionContent({
    required String headline,
    required String subheadline,
  }) async {
    try {
      await _firestore.collection('site_content').doc('landing_page').update({
        'heroHeadline': headline,
        'heroSubheadline': subheadline,
      });
      debugPrint('Conteúdo da Hero Section salvo com sucesso!');
      return true;
    } catch (e) {
      debugPrint('Erro ao salvar conteúdo da Hero Section: $e');
      return false;
    }
  }
}
