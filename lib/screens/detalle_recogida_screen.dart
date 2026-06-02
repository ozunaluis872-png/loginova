import 'package:flutter/material.dart';

import '../models/recogida.dart';
import 'evidencia_screen.dart';

class DetalleRecogidaScreen extends StatelessWidget {
  final Recogida recogida;

  const DetalleRecogidaScreen({super.key, required this.recogida});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Recogida')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'Cliente: #${recogida.clienteId}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text('Operador: #${recogida.usuarioId}'),

            const SizedBox(height: 10),

            Text('Paquetes: ${recogida.cantidadPaquetes}'),

            const SizedBox(height: 10),

            Text('Estado: ${recogida.estado}'),

            const SizedBox(height: 10),

            Text('Observaciones: ${recogida.observaciones}'),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),

                label: const Text('Agregar Evidencia'),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EvidenciaScreen(recogidaId: recogida.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
