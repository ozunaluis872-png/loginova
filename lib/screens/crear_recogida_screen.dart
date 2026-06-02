import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cliente.dart';
import '../models/recogida.dart';
import '../providers/auth_provider.dart';
import '../providers/recogida_provider.dart';
import '../services/cliente_service.dart';

class CrearRecogidaScreen extends StatefulWidget {
  const CrearRecogidaScreen({super.key});

  @override
  State<CrearRecogidaScreen> createState() => _CrearRecogidaScreenState();
}

class _CrearRecogidaScreenState extends State<CrearRecogidaScreen> {
  final clienteController = TextEditingController();
  final telefonoController = TextEditingController();
  final direccionController = TextEditingController();
  final ciudadController = TextEditingController();
  final paquetesController = TextEditingController();
  final observacionesController = TextEditingController();
  bool guardando = false;

  Future<void> guardar() async {
    setState(() => guardando = true);

    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final provider = Provider.of<RecogidaProvider>(context, listen: false);
      final cliente = await ClienteService().crearCliente(
        Cliente(
          id: 0,
          nombre: clienteController.text.trim(),
          telefono: telefonoController.text.trim(),
          direccion: direccionController.text.trim(),
          ciudad: ciudadController.text.trim(),
        ),
      );

      final recogida = Recogida(
        id: 0,
        clienteId: cliente.id,
        usuarioId: auth.usuario?.id ?? 1,
        estado: 'Pendiente',
        cantidadPaquetes: int.tryParse(paquetesController.text) ?? 0,
        observaciones: observacionesController.text.trim(),
        evidencias: const [],
      );

      await provider.agregarRecogida(recogida);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar la recogida')),
      );
    } finally {
      if (mounted) {
        setState(() => guardando = false);
      }
    }
  }

  @override
  void dispose() {
    clienteController.dispose();
    telefonoController.dispose();
    direccionController.dispose();
    ciudadController.dispose();
    paquetesController.dispose();
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Recogida')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: clienteController,
              decoration: const InputDecoration(
                labelText: 'Cliente',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: telefonoController,
              decoration: const InputDecoration(
                labelText: 'Telefono',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: direccionController,
              decoration: const InputDecoration(
                labelText: 'Direccion',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ciudadController,
              decoration: const InputDecoration(
                labelText: 'Ciudad',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: paquetesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad de paquetes',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: observacionesController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Observaciones',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: guardando ? null : guardar,

                child: Text(guardando ? 'Guardando...' : 'Guardar Recogida'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
