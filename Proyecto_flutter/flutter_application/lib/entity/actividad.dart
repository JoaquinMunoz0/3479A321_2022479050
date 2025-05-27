class Actividad {
  final int? id;
  final String fecha;
  final String nombre;

  Actividad({this.id, required this.fecha, required this.nombre});

  // Convertir la actividad a un mapa para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha,
      'nombre': nombre,
    };
  }

  // Crear una instancia desde un mapa (consulta SQLite)
  factory Actividad.fromMap(Map<String, dynamic> map) {
    return Actividad(
      id: map['id'],
      fecha: map['fecha'],
      nombre: map['nombre'],
    );
  }
}
