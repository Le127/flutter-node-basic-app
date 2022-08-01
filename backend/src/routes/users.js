const { Router } = require('express');
const router = Router();

//Importa el modelo User por ende están a disposicion todas las funciones para trabajar con la DB, ej: find o create
const User = require('../models/User.js');



router.get('/api/users', async (req, res) => {
    const users = await User.find(); //Busca todos los usuarios de la base de datos
    res.json({ users: users }); //Envía la respuesta de todos los usuarios de la base de datos, en formato JSON.
});
/* 
 router.get('/api/users/:id', async (req, res) => {
    const userId= req.params.id;
    const users = await User.findById(userId); //Busca el usuario con el id dado
    res.json({ users }); //Envía la respuesta del usuario con ese id, en formato JSON.
});  
 */


router.get('/api/users/create', async (req, res) => {
  for (let i = 0; i < 5; i++) {
        await User.create({
            firstName: `Jose${i}`,
            lastName: `Perez${i}`,
            avatar: `https://i.picsum.photos/id/602/700/400.jpg?hmac=nc2uHrWPx-Q8dESNWP953rdUGMOGKfl2b14-9SNI0QE`
        });
    } 

    res.json({ message: '5 Users created' });
});



//REMOVE ALL USERS
router.delete('/api/users/delete', async (req, res) => {
 
          await User.deleteMany();      
  
      res.json({ message: 'All users Delete' });
  });



module.exports = router;