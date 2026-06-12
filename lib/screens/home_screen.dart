import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/recogida_provider.dart';
import '../widgets/dashboard_card.dart';
import 'evidencia_screen.dart';
import 'mapa_screen.dart';
import 'perfil_screen.dart';
import 'recogidas_screen.dart';

/// Pantalla principal que muestra el dashboard y la navegación del usuario autenticado.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    /// Carga las recogidas cuando se inicializa la pantalla.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecogidaProvider>(context, listen: false).cargarRecogidas();
    });
  }

  /// Cierra la sesión del usuario y lo redirige a la pantalla de login.
  Future<void> cerrarSesion() async {
    await Provider.of<AuthProvider>(context, listen: false).logout();

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthProvider>(context).usuario;

    return Scaffold(
      appBar: AppBar(title: const Text('Loginova')),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const CircleAvatar(radius: 30, child: Icon(Icons.person)),

                  const SizedBox(height: 10),

                  Text(
                    usuario?.nombre ?? 'Administrador',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text('Recogidas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecogidasScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapaScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesion'),
              onTap: cerrarSesion,
            ),
          ],
        ),
      ),

      body: Consumer<RecogidaProvider>(
        builder: (context, provider, _) {
          final recogidas = provider.recogidas;
          final evidencias = recogidas.fold<int>(
            0,
            (total, item) => total + item.evidencias.length,
          );

          return RefreshIndicator(
            onRefresh: provider.cargarRecogidas,
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  if (provider.error != null)
                    Text(
                      provider.error!,
                      style: const TextStyle(color: Colors.red),
                    ),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,

                      crossAxisSpacing: 10,

                      mainAxisSpacing: 10,

                      children: [
                        DashboardCard(
                          titulo: 'Recogidas',
                          valor: provider.cargando
                              ? '...'
                              : '${recogidas.length}',
                          icono: Icons.local_shipping,
                        ),

                        DashboardCard(
                          titulo: 'Evidencias',
                          valor: '$evidencias',
                          icono: Icons.photo_camera,
                        ),

                        const DashboardCard(
                          titulo: 'Clientes',
                          valor: '-',
                          icono: Icons.people,
                        ),

                        const DashboardCard(
                          titulo: 'Operadores',
                          valor: '-',
                          icono: Icons.person,
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RecogidasScreen(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.local_shipping),

                    label: const Text('Gestionar Recogidas'),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MapaScreen()),
                      );
                    },

                    icon: const Icon(Icons.map),

                    label: const Text('Abrir Mapa'),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EvidenciaScreen(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.camera_alt),

                    label: const Text('Ver Evidencias'),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PerfilScreen()),
                      );
                    },

                    icon: const Icon(Icons.person),

                    label: const Text('Mi Perfil'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
