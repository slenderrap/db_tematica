"use strict";

const express = require("express");
const fs = require("fs");
const path = require("path");
const cors = require("cors");

// Crear la aplicación Express
const app = express();
const PORT = 3000;

//indicar la ruta de imagenes
app.use("/images", express.static(path.join(__dirname, "data/images")));
// Middleware para permitir solicitudes desde cualquier origen (CORS)
app.use(cors());

// Endpoint para obtener todos los álbumes
app.post("/api/albums", (req, res) => {
  const filePath = path.join(__dirname, "data", "albums.json");
  fs.readFile(filePath, "utf8", (err, data) => {
    if (err) {
      return res
        .status(500)
        .json({ error: "Error al leer los datos de los álbumes" });
    }
    return res.json(JSON.parse(data));
  });
});

// Endpoint para obtener todos los miembros
app.post("/api/members", (req, res) => {
  const filePath = path.join(__dirname, "data", "members.json");
  fs.readFile(filePath, "utf8", (err, data) => {
    if (err) {
      return res
        .status(500)
        .json({ error: "Error al leer los datos de los miembros" });
    }
    return res.json(JSON.parse(data));
  });
});

// Endpoint para obtener todos las canciones
app.post("/api/songs", (req, res) => {
  const filePath = path.join(__dirname, "data", "songs.json");
  fs.readFile(filePath, "utf8", (err, data) => {
    if (err) {
      return res
        .status(500)
        .json({ error: "Error al leer los datos de las canciones" });
    }
    return res.json(JSON.parse(data));
  });
});

// Endpoint para servir imágenes, express ya contiene un metodo get interno
app.use("/images", express.static(path.join(__dirname, "data/images")));

// Endpoint para manejar rutas no encontradas
app.use((req, res) => {
  res.status(404).json({ error: "Ruta no encontrada" });
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
