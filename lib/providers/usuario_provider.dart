import 'package:flutter/material.dart';

import '../models/usuario.dart';

class UsuarioProvider extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;

    notifyListeners();
  }

  void limpiar() {
    _usuario = null;

    notifyListeners();
  }
}
