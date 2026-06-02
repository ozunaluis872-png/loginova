import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/usuario_provider.dart';
import 'providers/recogida_provider.dart';

void main() {
  runApp(const LoginovaApp());
}

class LoginovaApp extends StatelessWidget {
  const LoginovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => UsuarioProvider()),

        ChangeNotifierProvider(create: (_) => RecogidaProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Loginova',

        initialRoute: '/',

        routes: AppRoutes.routes,
      ),
    );
  }
}
