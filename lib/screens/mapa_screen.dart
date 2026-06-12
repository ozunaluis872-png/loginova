import 'package:flutter/material.dart';

/// Pantalla que mostrará un mapa interactivo con las ubicaciones de las recogidas.
class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa')),
      body: const Center(
        child: Text('Aquí aparecerá el mapa', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
