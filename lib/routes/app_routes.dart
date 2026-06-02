import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const LoginScreen(),
    '/home': (context) => const HomeScreen(),
  };
}
