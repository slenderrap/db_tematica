class Member {
  final String name;
  final String role;
  final int yearsOld;
  final String bornYear; // Fecha de nacimiento (YYYY-MM-DD)
  final String bornLocate; // Lugar de nacimiento
  final List<String> instrumentos; // Lista de instrumentos
  final String education; // Educación

  Member({
    required this.name,
    required this.role,
    required this.yearsOld,
    required this.bornYear,
    required this.bornLocate,
    required this.instrumentos,
    required this.education,
  });

  // Método factory para crear un objeto Member a partir de JSON
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] ?? 'Sin nombre',
      role: json['role'] ?? 'Rol desconocido',
      yearsOld: json['yearsOld'] ?? 0,
      bornYear: json['born_year'] ?? 'Fecha desconocida',
      bornLocate: json['born_locate'] ?? 'Lugar desconocido',
      instrumentos: List<String>.from(json['instrumentos'] ?? []),
      education: json['education'] ?? 'Educación desconocida',
    );
  }

  // Método para convertir el objeto Member de vuelta a JSON (opcional)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'yearsOld': yearsOld,
      'born_year': bornYear,
      'born_locate': bornLocate,
      'instrumentos': instrumentos,
      'education': education,
    };
  }
}