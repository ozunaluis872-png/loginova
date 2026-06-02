import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final correoController = TextEditingController(text: 'admin@loginova.com');
  final passwordController = TextEditingController(text: 'admin123');

  Future<void> iniciarSesion() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok = await auth.login(
      correoController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;

    if (ok) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(auth.error ?? 'No se pudo iniciar sesion')),
    );
  }

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loginova')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: correoController,
              decoration: const InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contrasena',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Consumer<AuthProvider>(
              builder: (context, auth, _) {
                return SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: auth.cargando ? null : iniciarSesion,

                    child: Text(auth.cargando ? 'Ingresando...' : 'Ingresar'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
