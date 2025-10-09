// lib/models/contact_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String name;
  final String email;
  final String message;
  final Timestamp timestamp;

  ContactModel({
    required this.name,
    required this.email,
    required this.message,
    required this.timestamp,
  });

  // Converte nosso objeto em um Map, que é o formato que o Firestore entende
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
