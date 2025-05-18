import 'package:flutter/material.dart';

// Función para crear una ruta con animación personalizada
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
}