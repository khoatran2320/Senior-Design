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

	// check if boxiId exist
	const boxiRef = db.collection(BOXI_COLLECTION).doc(boxiId);
	const boxiDoc = await boxiRef.get();

	if (!boxiDoc.exists) {
		res.status(400).send('Invalid Boxi ID');
		return;
	}

	let boxi_ip = boxiDoc.get('ip_addr');
	let boxi_port = boxiDoc.get('port');

	axios
		.post('http://' + boxi_ip + ':' + boxi_port + '/unlock', {
			userId: userId,
			boxiId: boxiId
		})
		.then((r) => {
			console.log(r);
			res.status(200).send('Success!');
			return;
		})
		.catch((e) => {
			res.status(400).send('Unable to unlock box!');
			return;
		});
});

router.post('/signal-alarm', async (req, res) => {
	// Update a package to received for given Boxi ID
	const { userId, boxiId, alarmStatus } = req.body;

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

	// check if boxiId exist
	const boxiRef = db.collection(BOXI_COLLECTION).doc(boxiId);
	const boxiDoc = await boxiRef.get();

	if (!boxiDoc.exists) {
		res.status(400).send('Invalid Boxi ID');
		return;
	}

	let boxi_ip = boxiDoc.get('ip_addr');
	let boxi_port = boxiDoc.get('port');

	axios
		.post('http://' + boxi_ip + ':' + boxi_port + '/alarm', {
			userId: userId,
			boxiId: boxiId,
			status: alarmStatus
		})
		.then((r) => {
			res.status(200).send('Success!');
			return;
		})
		.catch((e) => {
			res.status(400).send('Unable turn on alarm!');
			return;
		});
});

router.post('/alarm-enable', async (req, res) => {
	// Turning on/off alarm on a Boxi given Boxi ID
	const { userId, boxiId, alarmEnable } = req.body;

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

	// check if boxiId exist
	const boxiRef = db.collection(BOXI_COLLECTION).doc(boxiId);
	const boxiDoc = await boxiRef.get();

	if (!boxiDoc.exists) {
		res.status(400).send('Invalid Boxi ID');
		return;
	}

	// update the boxi status to toggle alarm
	try {
		await boxiRef.update({ alarm_enable: alarmEnable });
	} catch (err) {
		res.status(400).send('Failed to post boxi alarm enable');
		return;
	}

	res.status(200).send('Success!');
	return;
});

router.get('/alarm-enable', async (req, res) => {
	// Get Boxi unlock status: true, false
	const { userId, boxiId } = req.query;

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

	// check if boxiId exist
	const boxiRef = db.collection(BOXI_COLLECTION).doc(boxiId);
	const boxiDoc = await boxiRef.get();

	if (!boxiDoc.exists) {
		res.status(400).send('Invalid Boxi ID');
		return;
	}

	const alarmEnable = boxiDoc.data()['alarm_enable'];
	res.status(200).send({ status_code: 200, data: alarmEnable, msg: 'Success!' });
	return;
});

module.exports = router;
