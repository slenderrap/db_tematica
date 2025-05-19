import 'package:db_tematica/widgets/animated_page_route.dart';
import 'package:flutter/material.dart';
import 'items_screen.dart'; // Importa la pantalla de Items

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'), // Título de la pantalla
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage('http://localhost:3000/images/queen_grupo.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(0,0,0,0.5), // Capa semi-transparente
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton(context, 'albums', 'Álbumes'),
                SizedBox(height: 16),
                _buildCategoryButton(context, 'members', 'Miembros'),
                SizedBox(height: 16),
                _buildCategoryButton(context, 'songs', 'Canciones'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para construir un botón de categoría
  Widget _buildCategoryButton(
      BuildContext context, String category, String label) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          AnimatedPageRoute(
            ItemsScreen(category: category), // Navega a la vista de Items
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
