import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _logueado = false;
  bool _cargando = false;
  Usuario? _usuario;
  String? _error;

  bool get logueado => _logueado;
  bool get cargando => _cargando;
  Usuario? get usuario => _usuario;
  String? get error => _error;

  AuthProvider() {
    cargarSesion();
  }

  Future<void> cargarSesion() async {
    await ApiService.loadToken();
    final usuarioJson = await ApiService.loadUsuarioJson();

    if (ApiService.token != null && usuarioJson != null) {
      _usuario = Usuario.fromJson(jsonDecode(usuarioJson));
      _logueado = true;
      notifyListeners();
    }
  }

  Future<bool> login(String correo, String password) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    final result = await _authService.login(correo, password);
    _cargando = false;

    if (result == null) {
      _logueado = false;
      _usuario = null;
      _error = 'Correo o contraseña incorrectos';
      notifyListeners();
      return false;
    }

    _logueado = true;
    _usuario = result.usuario;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await ApiService.clearSession();
    _logueado = false;
    _usuario = null;

    notifyListeners();
  }
}
