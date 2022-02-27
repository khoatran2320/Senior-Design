// Express Setup
const express = require('express');
const router = express.Router();

// PKGE 3rd Party API
const pkgeAPI = require('../pkge_api');

// Firebase setup
const auth = require('firebase-admin/auth');
const admin = require('firebase-admin');
const db = admin.firestore();
const PACKAGE_COLLECTION = 'user_packages';
const BOXI_COLLECTION = 'boxi';
const axios = require('axios').default;

router.post('/unlock-box', async (req, res) => {
	// Update a package to received for given Boxi ID
	const { userId, boxiId } = req.body;

	if (!userId) {
		res.status(400).send('Requires a user ID!');
		return;
	}
	if (!boxiId) {
		res.status(400).send('Requires a box ID!');
		return;
	}

	// check if user exist
	try {
		await auth.getAuth().getUser(userId);
	} catch (err) {
		//unable to find user
		if (err['errorInfo']['code'] == 'auth/user-not-found') {
			res.status(400).send('User does not exist');
			return;
		}
		res.status(400).send('Something went wrong!');
		return;
	}

	// check if user owns this box
	let userOwnsBox = false;
	try {
		const sshot = await db.collection(PACKAGE_COLLECTION).doc(userId).collection('boxes').get();
		sshot.forEach((doc) => {
			if (doc.id == boxiId) {
				userOwnsBox = true;
			}
		});
	} catch (err) {
		res.status(400).send('Something went wrong!');
		return;
	}

	if (!userOwnsBox) {
		res.status(403).send('User does not have access to this box!');
		return;
	}

    try{
        axios.post('http://10.192.4.148:4321/unlock', {
            'userId': userId,
            'boxiId': boxiId
          });
    }
    catch(err){
        res.status(400).send('Unable to open box!');
		return;
    }
	res.status(200).send('Success!');
	return;
});

router.post('/signal-alarm', async (req, res) => {
	// Update a package to received for given Boxi ID
	const { userId, boxiId } = req.body;

	if (!userId) {
		res.status(400).send('Requires a user ID!');
		return;
	}
	if (!boxiId) {
		res.status(400).send('Requires a box ID!');
		return;
	}

	// check if user exist
	try {
		await auth.getAuth().getUser(userId);
	} catch (err) {
		//unable to find user
		if (err['errorInfo']['code'] == 'auth/user-not-found') {
			res.status(400).send('User does not exist');
			return;
		}
		res.status(400).send('Something went wrong!');
		return;
	}

	// check if user owns this box
	let userOwnsBox = false;
	try {
		const sshot = await db.collection(PACKAGE_COLLECTION).doc(userId).collection('boxes').get();
		sshot.forEach((doc) => {
			if (doc.id == boxiId) {
				userOwnsBox = true;
			}
		});
	} catch (err) {
		res.status(400).send('Something went wrong!');
		return;
	}

	if (!userOwnsBox) {
		res.status(403).send('User does not have access to this box!');
		return;
	}

    try{
        axios.post('http://10.192.4.148:4321/alarm', {
            'userId': userId,
            'boxiId': boxiId
          });
    }
    catch(err){
        res.status(400).send('Unable to open box!');
		return;
    }
	res.status(200).send('Success!');
	return;
});

module.exports = router;
