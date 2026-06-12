import 'package:flutter/material.dart';

/// Pantalla que muestra la información del perfil del usuario autenticado.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: const Center(
        child: Text('Información del usuario', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
