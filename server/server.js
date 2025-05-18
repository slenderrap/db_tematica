'use strict';

const express = require('express');
const fs = require('fs');
const path = require('path');
const cors = require('cors');

// Crear la aplicación Express
const app = express();
const PORT = 3000;

// Middleware para permitir solicitudes desde cualquier origen (CORS)
app.use(cors());

// Endpoint para obtener todos los álbumes
app.get('/api/albums', (req, res) => {
  const filePath = path.join(__dirname, 'data', 'albums.json');
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      return res.status(500).json({ error: 'Error al leer los datos de los álbumes',err });
    }
    return res.json(JSON.parse(data));
  });
});

// Endpoint para obtener todos los miembros
app.get('/api/members', (req, res) => {
    const filePath = path.join(__dirname, 'data', 'members.json');
    console.log(`Ruta al archivo: ${filePath}`); // Depuración
    fs.readFile(filePath, 'utf8', (err, data) => {
      if (err) {
        console.error('Error al leer el archivo:', err);
        return res.status(500).json({ error: 'Error al leer los datos de los miembros' });
      }
      res.json(JSON.parse(data));
    });
  });

// Endpoint para obtener todas las canciones
app.get('/api/songs', (req, res) => {
  const filePath = path.join(__dirname, 'data', 'songs.json');
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      return res.status(500).json({ error: 'Error al leer los datos de las canciones' ,err});
    }
    return res.json(JSON.parse(data));
  });
});

// Endpoint para servir imágenes
app.get('/api/images/:imageName', (req, res) => {
    const imageName = req.params.imageName;
    const imagePath = path.join(__dirname, 'images', imageName);

    // Verificar si la imagen existe
    fs.access(imagePath, fs.constants.F_OK, (err) => {
      if (err) {
        return res.status(404).json({ error: 'Imagen no encontrada' });
      }

      // Obtener el tipo MIME de la imagen
      const mimeType = getMimeType(imageName);
      if (!mimeType) {
        return res.status(400).json({ error: 'Formato de imagen no soportado' });
      }

      // Leer y servir la imagen
      fs.readFile(imagePath, (err, data) => {
        if (err) {
          return res.status(500).json({ error: 'Error al leer la imagen' });
        }
        res.set('Content-Type', mimeType);
        res.send(data);
      });
    });
});

// Función para determinar el tipo MIME de la imagen
function getMimeType(filename) {
    const extension = filename.split('.').pop().toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      default:
        return null;
    }
}
  
  // Función para determinar el tipo MIME de la imagen
  function getMimeType(filename) {
    const extension = filename.split('.').pop().toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      default:
        return null;
    }
  }
  


// Endpoint para manejar rutas no encontradas
app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada' });
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});