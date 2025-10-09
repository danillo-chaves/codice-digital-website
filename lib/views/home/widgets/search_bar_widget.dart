// lib/views/home/widgets/search_bar_widget.dart

import 'package:codice_digital/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos um Padding para que a barra de pesquisa não ocupe toda a largura da AppBar
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          // Estilo do campo de texto
          hintText: 'Pesquisar...',
          hintStyle: TextStyle(color: AppColors.mutedPurple),
          filled: true,
          fillColor: AppColors.black.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ), // Bordas bem arredondadas
            borderSide: BorderSide.none, // Sem borda
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),

          // Ícone de lupa no início
          prefixIcon: Icon(Icons.search, color: AppColors.mutedPurple),
        ),
        style: TextStyle(color: AppColors.lightGray),
      ),
    );
  }
}
