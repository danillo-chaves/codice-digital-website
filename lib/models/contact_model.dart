// lib/models/contact_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String name;
  final String email;
  final String message;
  final Timestamp timestamp;
  final String status;
  final String phone;

  ContactModel({
    required this.name,
    required this.email,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
      'timestamp': timestamp,
      'status': status,
      'phone': phone,
    };
  }
}
