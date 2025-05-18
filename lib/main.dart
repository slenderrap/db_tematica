import 'package:flutter/material.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter DB temàtica',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CategoriesScreen(),
    );
  }
}
//fins aqui
/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  // Índice del elemento seleccionado en la barra lateral
  int _selectedIndex = 0;

  // Lista de títulos para la barra lateral
  final List<String> _titles = ['Álbumes', 'Miembros', 'Canciones'];

  // Método para manejar el cambio de selección en la barra lateral
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de QUEEN'),
      ),
      body: Row(
        children: [
          // Barra lateral
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all, // Muestra etiquetas siempre
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.album),
                label: Text('Álbumes'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Miembros'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.music_note),
                label: Text('Canciones'),
              ),
            ],
          ),

          // Espaciador vertical
          VerticalDivider(width: 1),

          // Contenido principal
          Expanded(
            child: Center(
              child: _buildContent(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  // Construye el contenido según el índice seleccionado
  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return _buildAlbumsTab();
      case 1:
        return _buildMembersTab();
      case 2:
        return _buildSongsTab();
      default:
        return Container(); // Opción por defecto
    }
  }

  // Función para cargar álbumes
  Widget _buildAlbumsTab() {
    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay álbumes disponibles'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final album = snapshot.data![index];
              return ListTile(
                title: Text(
                  album['name'] ?? 'Sin título',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    AnimatedPageRoute(
                      DetailScreen(
                        item: album,
                        title: album['name'] ?? 'Álbum desconocido',
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  // Función para cargar miembros
  Widget _buildMembersTab() {
    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchMembers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay miembros disponibles'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final member = snapshot.data![index];
              return ListTile(
                title: Text(
                  member['name'] ?? 'Sin nombre',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    AnimatedPageRoute(
                      DetailScreen(
                        item: member,
                        title: member['name'] ?? 'Miembro desconocido',
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  // Función para cargar canciones
  Widget _buildSongsTab() {
    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchSongs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay canciones disponibles'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final song = snapshot.data![index];
              return ListTile(
                title: Text(
                  song['title'] ?? 'Sin título',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    AnimatedPageRoute(
                      DetailScreen(
                        item: song,
                        title: song['title'] ?? 'Canción desconocida',
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}

// Pantalla de detalles
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  final String title;

  const DetailScreen({
    Key? key,
    required this.item,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...item.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      '${entry.key}: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        entry.value.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

Route<dynamic> AnimatedPageRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 500), // Duración de la animación
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Comienza fuera de la pantalla (derecha)
      const end = Offset.zero; // Termina en la posición normal
      const curve = Curves.easeInOut; // Curva de animación

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}*/