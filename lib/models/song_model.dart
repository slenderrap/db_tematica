class Song {
  final String title;
  final String album;
  final int year;
  final String duration; // Duración de la canción
  final String compositor; // Compositor

  Song({
    required this.title,
    required this.album,
    required this.year,
    required this.duration,
    required this.compositor,
  });

  // Método factory para crear un objeto Song a partir de JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['title'] ?? 'Sin título',
      album: json['album'] ?? 'Álbum desconocido',
      year: json['year'] ?? 0,
      duration: json['duration'] ?? 'Duración desconocida',
      compositor: json['compositor'] ?? 'Compositor desconocido',
    );
  }

  // Método para convertir el objeto Song de vuelta a JSON (opcional)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'album': album,
      'year': year,
      'duration': duration,
      'compositor': compositor,
    };
  }
}