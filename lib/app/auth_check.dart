// lib/app/auth_check.dart (COM OS CAMINHOS CORRIGIDOS)

import 'package:codice_digital/admin/admin_dashboard_page.dart'; // <-- CORRIGIDO
import 'package:codice_digital/admin/admin_login_page.dart'; // <-- CORRIGIDO
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const AdminDashboardPage();
        }

        return const AdminLoginPage();
      },
    );
  }
}
