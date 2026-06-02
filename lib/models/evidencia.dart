class Evidencia {
  final int id;
  final int recogidaId;
  final String fotoUrl;
  final String comentario;

  Evidencia({
    required this.id,
    required this.recogidaId,
    required this.fotoUrl,
    required this.comentario,
  });

  factory Evidencia.fromJson(Map<String, dynamic> json) {
    return Evidencia(
      id: json['id'],
      recogidaId: json['recogidaId'],
      fotoUrl: json['fotoUrl'],
      comentario: json['comentario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recogidaId': recogidaId,
      'fotoUrl': fotoUrl,
      'comentario': comentario,
    };
  }
}
