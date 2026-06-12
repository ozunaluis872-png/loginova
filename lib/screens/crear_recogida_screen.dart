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

  final _formKey = GlobalKey<FormState>();

  Future<void> guardar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => guardando = true);

    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final provider = Provider.of<RecogidaProvider>(context, listen: false);

      if (auth.usuario == null) {
        throw Exception('Sesion invalida');
      }

      final cliente = await ClienteService().crearCliente(
        Cliente(
          id: 0,
          nombre: clienteController.text.trim(),
          telefono: telefonoController.text.trim(),
          direccion: direccionController.text.trim(),
          ciudad: ciudadController.text.trim(),
        ),
      );

      final cantidadPaquetes =
          int.tryParse(paquetesController.text.trim()) ?? 0;
      if (cantidadPaquetes < 0) {
        throw Exception('Cantidad de paquetes invalida');
      }

      final recogida = Recogida(
        id: 0,
        clienteId: cliente.id,
        usuarioId: auth.usuario!.id,
        estado: 'Pendiente',
        cantidadPaquetes: cantidadPaquetes,
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

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: clienteController,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa el nombre del cliente';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Telefono',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa el telefono del cliente';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: direccionController,
                decoration: const InputDecoration(
                  labelText: 'Direccion',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa la direccion';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: ciudadController,
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa la ciudad';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: paquetesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad de paquetes',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa la cantidad de paquetes';
                  }
                  final parsed = int.tryParse(value);
                  if (parsed == null || parsed < 0) {
                    return 'Ingresa un numero valido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: observacionesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Observaciones',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa una observacion';
                  }
                  return null;
                },
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
      ),
    );
  }
}
