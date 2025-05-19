import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Importa el servicio API
import '../models/album_model.dart'; // Modelo de álbumes
import '../models/member_model.dart'; // Modelo de miembros
import '../models/song_model.dart'; // Modelo de canciones
import '../widgets/animated_page_route.dart'; // Animación de transición
import 'detail_screen.dart'; // Pantalla de detalles

class ItemsScreen extends StatelessWidget {
  final String category;

  const ItemsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_capitalize(category)), // Título basado en la categoría
      ),
            body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://localhost:3000/images/queen_grupo.jpg'), // URL de la imagen
                fit: BoxFit.fill, // Ajusta la imagen al contenedor
              ),
            ),
          ),
          // Capa semi-transparente para mejorar la legibilidad
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.5), // Negro con 50% de opacidad
          ),
          // Contenido principal
          FutureBuilder<List<dynamic>>(
            future: _fetchData(category), // Obtiene los datos del servidor
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No hay elementos disponibles'));
              } else {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey),
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ListTile(
                      leading: _buildLeading(category, item), // Ícono dinámico según la categoría
                      title: Text(
                        _getTitle(item, category), // Título dinámico según la categoría
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: _getSubtitle(item, category), // Subtítulo dinámico según la categoría
                      onTap: () {
                        Navigator.push(
                          context,
                          AnimatedPageRoute(
                            DetailScreen(
                              item: item, // Pasa el objeto completo
                              title: _getTitle(item, category), // Título dinámico
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Función para obtener los datos según la categoría
  Future<List<dynamic>> _fetchData(String category) async {
    final apiService = ApiService();
    switch (category) {
      case 'albums':
        return apiService.fetchAlbums(); // Devuelve una lista de álbumes
      case 'members':
        return apiService.fetchMembers(); // Devuelve una lista de miembros
      case 'songs':
        return apiService.fetchSongs(); // Devuelve una lista de canciones
      default:
        throw Exception('Categoría no válida');
    }
  }

  // Función para obtener el ícono dinámico según la categoría
  Icon _getLeadingIcon(String category) {
    switch (category) {
      case 'albums':
        return Icon(Icons.album, color: Colors.blue);
      case 'members':
        return Icon(Icons.person, color: Colors.green);
      case 'songs':
        return Icon(Icons.music_note, color: Colors.purple);
      default:
        return Icon(Icons.question_mark, color: Colors.grey);
    }
  }


  // Función para obtener el subtítulo dinámico según la categoría
  Widget _getSubtitle(dynamic item, String category) {
    switch (category) {
      case 'albums':
        final album = item as Album;
        return Text(
          '${album.year} - ${album.genre}',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        );
      case 'members':
        final member = item as Member;
        return Text(
          '${member.role} (${member.bornLocate})',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        );
      case 'songs':
        final song = item as Song;
        return Text(
          '${song.album} (${song.year})',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        );
      default:
        return Text(
          'Detalles no disponibles',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        );
    }
  }

// Acceso dinámico al título principal
  String _getTitle(dynamic item, String category) {
    switch (category) {
      case 'albums':
        final album = item as Album;
        return album.name;
      case 'members':
        final member = item as Member;
        return member.name;
      case 'songs':
        final song = item as Song;
        return song.title; // Usamos 'title' para canciones
      default:
        return 'Sin título';
    }
  }

  // Función para capitalizar el nombre de la categoría
  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }


// Función para construir el leading dinámico
Widget _buildLeading(String category, dynamic item) {
  // Verifica si el campo "image" existe y no es 'none'
  final imageName = _getImageName(item);

  if (imageName != null && imageName != 'none') {
    return Image.network(
      'http://localhost:3000/images/$imageName', // Construye la URL completa
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Si hay un error al cargar la imagen, muestra el ícono de la categoría
        return _getLeadingIcon(category);
      },
    );
  } else {
    // Si no hay imagen o es 'none', muestra el ícono de la categoría
    return _getLeadingIcon(category);
  }
}
String? _getImageName(dynamic item) {
  if (item is Album) {
    return item.image; // Accede al campo image del álbum
  } else if (item is Member) {
    return item.image; // Accede al campo image del miembro
  } else if (item is Song) {
    return item.image; // Accede al campo image de la canción
  } else {
    return null; // Si el objeto no es un tipo conocido, devuelve null
  }
}
}