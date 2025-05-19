import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Importa el servicio API
import '../models/album_model.dart'; // Modelo de álbumes
import '../models/member_model.dart'; // Modelo de miembros
import '../models/song_model.dart'; // Modelo de canciones

class DetailScreen extends StatelessWidget {
  final dynamic item; // El objeto que contiene los detalles del elemento
  final String title; // Título de la pantalla

  const DetailScreen({
    Key? key,
    required this.item,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String category = _getCategoryFromItem(item); // Obtén la categoría basada en el tipo de elemento
    final String? imageName = _getImageName(item); // Obtén el nombre de la imagen

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Color.fromRGBO(172, 135, 135, 0.886),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Mostrar imagen o ícono
                _buildImageOrIcon(category, imageName),
                SizedBox(height: 32),
                ..._buildDetailsList(item), // Lista de detalles dinámica
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función para construir la imagen o el ícono
  Widget _buildImageOrIcon(String category, String? imageName) {
    if (imageName != null && imageName.isNotEmpty) {
      return Image.network(
        'http://localhost:3000/images/$imageName', // Construye la URL completa
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error al cargar la imagen: $error');
          return _getCategoryIcon(category);
        },
      );
    } else {
      // Si no hay imagen o es vacío, muestra el ícono de la categoría
      return _getCategoryIcon(category);
    }
  }

  // Función para obtener el ícono según la categoría
  Widget _getCategoryIcon(String category) {
    switch (category) {
      case 'albums':
        return Icon(Icons.album, size: 100, color: Colors.blue);
      case 'members':
        return Icon(Icons.person, size: 100, color: Colors.green);
      case 'songs':
        return Icon(Icons.music_note, size: 100, color: Colors.purple);
      default:
        return Icon(Icons.error, size: 100, color: Colors.red);
    }
  }

  // Función para determinar la categoría basada en el tipo de elemento
  String _getCategoryFromItem(dynamic item) {
    if (item is Song) {
      return 'songs';
    } else if (item is Album) {
      return 'albums';
    } else if (item is Member) {
      return 'members';
    } else {
      return 'unknown';
    }
  }

  // Función para obtener el nombre de la imagen
  String? _getImageName(dynamic item) {
    if (item is Album) {
      return item.image;
    } else if (item is Member) {
      return item.image; // Asumiendo que Member tiene un campo image
    } else if (item is Song) {
      return item.image; // Asumiendo que Song tiene un campo image
    }
    return null;
  }

// Función para construir una lista de detalles a partir del objeto
List<Widget> _buildDetailsList(dynamic item) {
  final Map<String, dynamic> map = item.toJson(); // Convierte el objeto a un mapa
  return map.entries.map((entry) {
    // Verifica si el valor es una lista y convierte a cadena separada por comas
    String value = entry.value is List
        ? (entry.value as List).join(', ') // Convierte la lista en una cadena separada por comas
        : entry.value?.toString() ?? 'N/A';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centra horizontalmente
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '${entry.key}: ', // Clave (nombre del campo)
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.right, // Alinea las claves a la derecha
            ),
          ),
          SizedBox(width: 8), // Espacio entre clave y valor
          Expanded(
            flex: 3,
            child: Text(
              value, // Valor del campo (ahora puede ser una cadena separada por comas)
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left, // Alinea los valores a la izquierda
            ),
          ),
        ],
      ),
    );
  }).toList();
}

}