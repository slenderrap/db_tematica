import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Importa el servicio API

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> item; // El objeto que contiene los detalles del elemento
  final String title; // Título de la pantalla

  const DetailScreen({Key? key, required this.item, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final String? imageName = item['imageName']; // Nombre de la imagen desde el JSON

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Muestra la imagen
            if (imageName != null)
              Image.network(
                apiService.getImageUrl(imageName), // Obtiene la URL de la imagen
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text('No se pudo cargar la imagen'),
                  );
                },
              )
            else
              Center(
                child: Text('Imagen no disponible'),
              ),

            SizedBox(height: 16),

            // Detalles del elemento
            Text(
              'Detalles:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ..._buildDetailsList(item), // Lista de detalles dinámica
          ],
        ),
      ),
    );
  }

  // Función para construir una lista de detalles a partir del objeto
  List<Widget> _buildDetailsList(Map<String, dynamic> item) {
    return item.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '${entry.key}: ', // Clave (nombre del campo)
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                entry.value.toString(), // Valor del campo
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}