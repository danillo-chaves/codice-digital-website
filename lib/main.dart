// lib/main.dart (VERSÃO LIMPA)
import 'package:codice_digital/app/app_widget.dart';
import 'package:codice_digital/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppWidget());
}
