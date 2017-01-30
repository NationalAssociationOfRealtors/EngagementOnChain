'use strict';

const User = require('./user.model');
const BlockchainService = require('../../../services/blockchainSrvc.js');




/*
    Retrieve user object

    METHOD: GET
    URL: /api/v1/user/:userId
    Response:
        { user }
*/
exports.getUser = function(req, res) {
    console.log("-- Query user --")

    const functionName = "get_user";
    const args = [req.params.userId];

    BlockchainService.query(functionName,args,req.userId).then(function(user){
        if (!user) {
            res.json([]);
        } else {
            console.log("Retrieved user from the blockchain");
            res.json(user)
        }
    }).catch(function(err){
        console.log("Error", err);
        res.sendStatus(500);
    });
};

/*
    Add user object

    METHOD: POST
    URL: /api/v1/user/
    Response:
        {  }
*/
exports.addThing = function(req, res) {
    console.log("-- Adding user --")

    const functionName = "add_user";
    const args = [req.body.userId, JSON.stringify(req.body.user)];

    BlockchainService.invoke(functionName,args,req.userId).then(function(user){
        res.sendStatus(200);
    }).catch(function(err){
        console.log("Error", err);
        res.sendStatus(500);
    });
};
