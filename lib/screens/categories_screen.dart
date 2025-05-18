import 'package:flutter/material.dart';
import 'items_screen.dart'; // Importa la pantalla de Items

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'), // Título de la pantalla
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los botones verticalmente
          children: [
            _buildCategoryButton(context, 'albums', 'Álbumes'),
            SizedBox(height: 16), // Espaciado entre botones
            _buildCategoryButton(context, 'members', 'Miembros'),
            SizedBox(height: 16),
            _buildCategoryButton(context, 'songs', 'Canciones'),
          ],
        ),
      ),
    );
  }

  // Función para construir un botón de categoría
  Widget _buildCategoryButton(BuildContext context, String category, String label) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemsScreen(category: category), // Navega a la vista de Items
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50), // Tamaño mínimo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18), // Estilo del texto del botón
      ),
    );
  }
}