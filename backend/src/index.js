const app = require('./app');
const { dbConnection } = require('./database/config');

async function main() {
    //Database connection
    await dbConnection();

    //Inicia servidor //  Donde dice que es localhost?
    await app.listen(4000);
    console.log('Server on port 4000: Connected')

}
//Inicializa el server
main();