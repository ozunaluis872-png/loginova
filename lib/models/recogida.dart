class Recogida {
  final int id;

  final int clienteId;

  final int usuarioId;

  final String estado;

  final int cantidadPaquetes;

  final String observaciones;

  final List<String> evidencias;

  Recogida({
    required this.id,

    required this.clienteId,

    required this.usuarioId,

    required this.estado,

    required this.cantidadPaquetes,

    required this.observaciones,

    required this.evidencias,
  });

  factory Recogida.fromJson(Map<String, dynamic> json) {
    return Recogida(
      id: json['id'],

      clienteId: json['clienteId'],

      usuarioId: json['usuarioId'],

      estado: json['estado'],

      cantidadPaquetes: json['cantidadPaquetes'],

      observaciones: json['observaciones'],

      evidencias: List<String>.from(json['evidencias'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteId': clienteId,
      'usuarioId': usuarioId,
      'estado': estado,
      'cantidadPaquetes': cantidadPaquetes,
      'observaciones': observaciones,
      'evidencias': evidencias,
    };
  }

  Map<String, dynamic> toRequestJson() {
    return {
      'clienteId': clienteId,
      'usuarioId': usuarioId,
      'estado': estado,
      'cantidadPaquetes': cantidadPaquetes,
      'observaciones': observaciones,
    };
  }
}
