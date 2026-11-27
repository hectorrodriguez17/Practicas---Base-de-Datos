
const express = require('express');
const pool = require('./conexion');

const app = express();

app.use(express.json());

app.get('/api/hola', (req, res) => {
    res.send('Hola, mi API funciona correctamente');
});

// Endpoint 1: comprobar que funciona la API
app.get('/api', (req, res) => {
    res.json({
        mensaje: 'Mi API funciona correctamente'
    });
});
app.get('/api/hola', (req, res) => {
    res.send('La nueva ruta funciona');
});

// Endpoint 2: comprobar conexion con PostgreSQL
app.get('/api/prueba-db', async (req, res) => {
    try {
        const resultado = await pool.query('SELECT NOW()');

        res.json({
            mensaje: 'Conexion con PostgreSQL exitosa',
            fecha: resultado.rows[0].now
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            mensaje: 'Error de conexion con PostgreSQL'
        });
    }
});

// Iniciar servidor
app.listen(3000, () => {
    console.log('API ejecutandose en el puerto 3000');
});