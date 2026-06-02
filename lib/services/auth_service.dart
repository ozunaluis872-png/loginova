import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';
import 'api_service.dart';

class AuthResult {
  final String token;
  final Usuario usuario;

  AuthResult({required this.token, required this.usuario});
}

class AuthService {
  Future<AuthResult?> login(String correo, String password) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/login'),

      headers: ApiService.jsonHeaders,

      body: jsonEncode({'correo': correo, 'password': password}),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final token = data['token'] as String;
    final usuario = Usuario.fromJson(data['usuario']);

    await ApiService.saveSession(token, jsonEncode(usuario.toJson()));

    return AuthResult(token: token, usuario: usuario);
  }
}
