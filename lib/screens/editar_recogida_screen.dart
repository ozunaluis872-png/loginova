import 'package:flutter/material.dart';

/// Pantalla que permite editar los datos de una recogida existente.
class EditarRecogidaScreen extends StatefulWidget {
  final Map<String, dynamic> recogida;

  const EditarRecogidaScreen({super.key, required this.recogida});

  @override
  State<EditarRecogidaScreen> createState() => _EditarRecogidaScreenState();
}

class _EditarRecogidaScreenState extends State<EditarRecogidaScreen> {
  late TextEditingController clienteController;
  late TextEditingController direccionController;

  @override
  void initState() {
    super.initState();

    /// Inicializa los controladores con los datos actuales.
    clienteController = TextEditingController(text: widget.recogida['cliente']);
    direccionController = TextEditingController(
      text: widget.recogida['direccion'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Recogida')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: clienteController,
              decoration: const InputDecoration(labelText: 'Cliente'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: direccionController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            const SizedBox(height: 20),

            /// Botón para guardar los cambios realizados.
            ElevatedButton(
              onPressed: () {
                widget.recogida['cliente'] = clienteController.text;
                widget.recogida['direccion'] = direccionController.text;
                Navigator.pop(context);
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
