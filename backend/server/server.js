const express = require('express');
const mongoose = require('mongoose');
const portNumber = process.env.port || 8686;
const app = express();

mongoose.connect('mongodb://localhost:27017/TillaDB',
  {
    useNewUrlParser: true,
  }
);

const connection = mongoose.connection;

app.use(express.json());

const userRoute = require('./routes/userRoute');

app.use('/user', userRoute);

app.route('/').get((req, res) => res.json("The Rest API is created."));

app.listen(portNumber, () => {
    console.log('Running on port %d', portNumber);
});