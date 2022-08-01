const mongoose = require('mongoose');



const dbConnection = async () => {

    try {
        //Conexión con MongoDB
        await mongoose.connect(process.env.MONGODB_CNN, {
            useNewUrlParser: true,
        });

        console.log('Mongo DataBase connected.');

    } catch (error) {
        console.log(error);
        throw new Error('Error al momento de iniciar la base de datos');
    }


}



module.exports = {
    dbConnection
}