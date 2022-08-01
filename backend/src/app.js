const express = require('express');
require('dotenv').config();
const app = express();

const morgan = require('morgan');
const cors = require('cors');

//Middleware
app.use(morgan('dev'));
app.use(cors());

// rutas?
app.use(require('./routes/users'));

module.exports = app;