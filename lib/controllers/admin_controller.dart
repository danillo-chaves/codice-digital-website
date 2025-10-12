import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- MÉTODOS DE AUTENTICAÇÃO ---

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("Login bem-sucedido: ${userCredential.user!.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Erro no login: ${e.message}");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("Logout bem-sucedido!");
    } catch (e) {
      debugPrint("Erro no logout: $e");
    }
  }

  // --- MÉTODO PARA LEADS (CONTATOS) ---

  Stream<QuerySnapshot> getContactsStream() {
    return _firestore
        .collection('contacts')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // --- MÉTODOS PARA GERENCIAMENTO DE CONTEÚDO ---

  Future<Map<String, dynamic>?> loadPageContent() async {
    try {
      final doc = await _firestore
          .collection('site_content')
          .doc('landing_page')
          .get();
      if (doc.exists) {
        debugPrint('Conteúdo da Landing Page carregado para edição.');
        return doc.data();
      }
    } catch (e) {
      debugPrint('Erro ao carregar conteúdo para edição: $e');
    }
    return null;
  }

  // Método de salvar genérico para atualizar o documento da landing page
  Future<bool> savePageContent({
    required Map<String, dynamic> dataToSave,
  }) async {
    try {
      await _firestore
          .collection('site_content')
          .doc('landing_page')
          .update(dataToSave);
      debugPrint('Conteúdo da Landing Page salvo com sucesso!');
      return true;
    } catch (e) {
      debugPrint('Erro ao salvar conteúdo da Landing Page: $e');
      return false;
    }
  }
}
