const { Router } = require('express');
const router = Router();

//Importa el modelo User por ende están a disposicion todas las funciones para trabajar con la DB, ej: find o create
const User = require('../models/User.js');


//Get AllUsers
router.get('/api/users', async (req, res) => {
    const users = await User.find(); //Busca todos los usuarios de la base de datos
    res.json({ users: users }); //Envía la respuesta de todos los usuarios de la base de datos, en formato JSON.
});



//Update User
router.put('/api/users/update/:id', async (req, res) => {

    const { firstName, lastName, avatar } = req.body;
    const { id } = req.params;
    const user = await User.findByIdAndUpdate(id, { firstName, lastName, avatar }, { new: true })

    // .then(user => res.json(user))
    // .catch(err => res.json(err));
    // res.json({ user }); //Envía la respuesta del usuario con ese id, en formato JSON.
    res.json({ message: `ACTUALIZADO EL Usuario ${id}`, user: user })
});






// Create 5 users
router.post('/api/users/create', async (req, res) => {
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
    await User.remove();
    res.json({ message: 'All users Delete' });
});



//Delete One User
router.delete('/api/users/delete/:id', async (req, res) => {
    const userId = req.params.id;
    const user = await User.findByIdAndDelete(userId); //Busca el usuario con el id dado

    res.json({ message: `User ID:${user.id} was deleted.` }); //Envía la respuesta del usuario con ese id, en formato JSON.
});


module.exports = router;