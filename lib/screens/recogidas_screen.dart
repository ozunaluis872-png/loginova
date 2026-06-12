import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recogida_provider.dart';
import 'crear_recogida_screen.dart';
import 'detalle_recogida_screen.dart';

/// Pantalla que muestra la lista de recogidas con opciones de crear, editar y eliminar.
class RecogidasScreen extends StatefulWidget {
  const RecogidasScreen({super.key});

  @override
  State<RecogidasScreen> createState() => _RecogidasScreenState();
}

class _RecogidasScreenState extends State<RecogidasScreen> {
  @override
  void initState() {
    super.initState();

    /// Carga las recogidas cuando se inicializa la pantalla.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecogidaProvider>(context, listen: false).cargarRecogidas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecogidaProvider>(context);
    final recogidas = provider.recogidas;

    return Scaffold(
      appBar: AppBar(title: const Text('Recogidas')),

      /// Botón flotante para crear nueva recogida.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CrearRecogidaScreen()),
          );
        },
      ),

      /// Lista de recogidas con capacidad de actualizar arrastrando.
      body: RefreshIndicator(
        onRefresh: provider.cargarRecogidas,
        child: provider.cargando
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: recogidas.length,
                itemBuilder: (context, index) {
                  final item = recogidas[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: const Icon(Icons.local_shipping),
                      title: Text('Cliente #${item.clienteId}'),
                      subtitle: Text(
                        'Observaciones: ${item.observaciones}\nPaquetes: ${item.cantidadPaquetes}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(item.estado),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await provider.eliminarRecogida(item.id);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetalleRecogidaScreen(recogida: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
