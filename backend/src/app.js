const express = require('express');
require('dotenv').config();
const app = express();

const morgan = require('morgan');
const cors = require('cors');

//Middleware
app.use(morgan('dev'));
app.use(cors());
//Contiene bodyparser
app.use(express.json());

// rutas?
app.use(require('./routes/users'));

module.exports = app;