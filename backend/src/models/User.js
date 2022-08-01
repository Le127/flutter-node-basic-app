const { Schema, model } = require('mongoose');

//Este es el esquema de los datos que se van a guardar en la db
const userSchema = new Schema({

    firstName: String,
    lastName: String,
    avatar: String,
});

//se crea y exporta el modelo con el esquema
module.exports = model('User', userSchema);