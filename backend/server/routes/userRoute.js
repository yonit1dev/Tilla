const express = require('express');
const config = require('../config');
const jwt = require('jsonwebtoken');
// let middlecheck = require('../middlecheck');
const User = require('../models/userModel');

const router = express.Router();

// Sign in user endpoint
router.route("/:email").get((req, res) => {
    User.findOne({ email: req.params.email }, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      return res.json({
        data: result,
        email: req.params.email,
      });
    });
  });

// Check email
router.route("/verifyEmail/:email").get((req, res) => {
    User.findOne({email: req.params.email}, (err, result) => {
        if(err) return res.status(500).json({msg: err});
        if(result != null){
            return res.json({Status: true});
        } else return res.json({Status: false});
    });
});

router.route('/login').post((req, res) => {

    User.findOne({email: req.body.email},
        (err, result) => {

            if(err) return res.status(500).json({msg: err});

            if(result === null){
                return res.status(403).json("Username is incorrect.");
            }

            if(result.password === req.body.password){

                let jwtoken = jwt.sign({email: req.body.email}, config.key, {});

                res.json({
                    token: jwtoken,
                    msg: "Verified",
                });
            }
            else{
                res.status(403).json("Password is incorrect!");
            }
        }
    );

})

// Sign up a user endpoint
router.route('/register').post((req, res) => {

    const user = new User({
        fullName: req.body.fullName,
        email: req.body.email,
        password: req.body.password
    });

    user.save().then(() => {
        console.log("Registered");
        res.status(200).json('OK');
    }).catch((err) => {
        res.status(403).json({msg : err});
    })

    res.json('Registered');

});

// Update user details such as password endpoint
router.route('/update/:email').patch((req, res) => {

    // Locate user using email and change password
    User.findOneAndUpdate(
        {
            email: req.params.email
        },
        {
            $set: {password: req.body.password}
        },
        (err, result) => {
            if(err) return res.status(500).json({msg: err});
            const msg = {
                msg: "Password reset successful!",
                email: req.params.email
            };

            return res.json(msg);
        }
    )

});

// Delete user endpoint
router.route('/delete/:email').delete((req, res) => {

    // Locate user and delete
    User.findOneAndDelete(
        {
            email: req.params.email
        },
        (err, result) => {
            if(err) return res.status(500).json({msg: err});
            
            const msg = {
                msg: "User Deleted!",
                email: req.params.email
            };

            return res.json(msg)
        }
    )

});

module.exports = router;