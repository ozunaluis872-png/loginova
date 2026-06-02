class Cliente {
  final int id;
  final String nombre;
  final String telefono;
  final String direccion;
  final String ciudad;

  Cliente({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.ciudad,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      ciudad: json['ciudad'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'direccion': direccion,
      'ciudad': ciudad,
    };
  }

  Map<String, dynamic> toRequestJson() {
    return {
      'nombre': nombre,
      'telefono': telefono,
      'direccion': direccion,
      'ciudad': ciudad,
    };
  }
}
