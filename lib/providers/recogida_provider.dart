import 'package:flutter/material.dart';

import '../models/recogida.dart';
import '../services/recogida_service.dart';

class RecogidaProvider extends ChangeNotifier {
  final RecogidaService _service = RecogidaService();
  final List<Recogida> _recogidas = [];
  bool _cargando = false;
  String? _error;

  List<Recogida> get recogidas => List.unmodifiable(_recogidas);
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> cargarRecogidas() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _service.obtenerRecogidas();
      _recogidas
        ..clear()
        ..addAll(data);
    } catch (_) {
      _error = 'No se pudieron cargar las recogidas';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> agregarRecogida(Recogida recogida) async {
    final creada = await _service.crearRecogida(recogida);
    _recogidas.add(creada);

    notifyListeners();
  }

  Future<void> actualizarRecogida(Recogida recogida) async {
    await _service.actualizarRecogida(recogida);
    final index = _recogidas.indexWhere((item) => item.id == recogida.id);

    if (index != -1) {
      _recogidas[index] = recogida;
    }

    notifyListeners();
  }

  Future<void> eliminarRecogida(int id) async {
    await _service.eliminarRecogida(id);
    _recogidas.removeWhere((item) => item.id == id);

    notifyListeners();
  }

  void agregarRecogidaLocal(Recogida recogida) {
    _recogidas.add(recogida);

    notifyListeners();
  }
}
