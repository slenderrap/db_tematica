class Album {
  final String name;
  final int year;
  final String genre;
  final String discografy;
  final String image;

  // Constructor principal
  Album({
    required this.name,
    required this.year,
    required this.genre,
    required this.discografy,
    required this.image
  });

  // Método factory para crear un objeto Album a partir de JSON
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'] ??
          'Sin título', // Valor por defecto si el campo está vacío
      year: json['year'] ?? 0,
      genre: json['genre'] ?? 'Género desconocido',
      discografy: json['discografy'] ?? 'Discográfica desconocida',
      image: json['image'] ?? 'none',
    );
  }

  // Método para convertir el objeto Album de vuelta a JSON (opcional)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'year': year,
      'genre': genre,
      'discografy': discografy,
      'image':image
    };
  }
}
