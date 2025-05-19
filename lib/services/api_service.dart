import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart'; // Modelo de álbumes
import '../models/member_model.dart'; // Modelo de miembros
import '../models/song_model.dart'; // Modelo de canciones

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  String getImageUrl(String imageName) {
    return '$baseUrl/data/images/$imageName'; // Construye la URL completa
  }

  // Método para obtener la lista de álbumes
  Future<List<Album>> fetchAlbums() async {
    final response = await http.post(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los álbumes');
    }
  }

  // Método para obtener la lista de miembros
  Future<List<Member>> fetchMembers() async {
    final response = await http.post(Uri.parse('$baseUrl/members'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Member.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los miembros');
    }
  }

  // Método para obtener la lista de canciones
  Future<List<Song>> fetchSongs() async {
    final response = await http.post(Uri.parse('$baseUrl/songs'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las canciones');
    }
  }
}
