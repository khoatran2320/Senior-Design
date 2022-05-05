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

router.get('/package', (req, res) => {
	const { userId, boxiId, trackingNumber } = req.query;

	if (!trackingNumber) {
		res.status(400).send('Requires a tracking number!');
		return;
	}
	if (!userId) {
		res.status(400).send('Requires a user ID!');
		return;
	}
	if (!boxiId) {
		res.status(400).send('Invalid box ID!');
		return;
	}

	//check user id
	auth
		.getAuth()
		.getUser(userId)
		.then(async (user) => {
			//user found, verify user owns box
			let userOwnsBox = false;
			const sshot = await db.collection(PACKAGE_COLLECTION).doc(userId).collection('boxes').get();
			sshot.forEach((doc) => {
				if (doc.id == boxiId) {
					userOwnsBox = true;
				}
			});
			if (!userOwnsBox) {
				res.status(403).send('User does not have access to this box!');
				return;
			}
			//verify user owns package
			let userOwnsPackage = false;
			const snapshot = await db.collection(PACKAGE_COLLECTION).doc(userId).collection('trackings').get();
			snapshot.forEach((doc) => {
				if (doc.id == trackingNumber) {
					userOwnsPackage = true;
				}
			});
			if (userOwnsPackage) {
				//check package status
				pkgeAPI
					.getPackage(trackingNumber)
					.then((pkgeInfo) => {
						//validate if package is on the way
						// 3: package is in transit
						// 4: package is pending delivery
						// 5: delivered
						if (pkgeInfo['status'] == 3 || pkgeInfo['status'] == 4 || pkgeInfo['status'] == 5) {
							res.status(200).send('Package expected!');
							return;
						} else {
							//package has not been shipped, has been delivered, or otherwise not expected to be delivered soon
							res.status(400).send('Package not expected!');
							return;
						}
					})
					.catch((e) => {
						res.status(400).send(e);
						return;
					});
			} else {
				//package does not belong to user
				res.status(400).send('Package does not exist');
				return;
			}
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send('User does not exist');
				return;
			}
			res.status(400).send('Soomething went wrong!');
			return;
		});
});

router.post('/add-box', (req, res) => {
	const { userId, boxiId } = req.body;

	if (!userId) {
		res.status(400).send('Requires a user ID!');
		return;
	}
	if (!boxiId) {
		res.status(400).send('Requires a box ID!');
		return;
	}
	//check to see if user exists
	auth
		.getAuth()
		.getUser(userId)
		.then((user) => {
			//user exists, add reference to box id
			const docRef = db.collection(PACKAGE_COLLECTION).doc(userId).collection('boxes').doc(boxiId);
			docRef
				.set({
					status: 'box added'
				})
				.then((r) => {
					//everything went smoothly
					res.status(200).send('Success!');
					return;
				})
				.catch((e) => {
					//unable to write to firestore
					res.status(400).send('Unable to write to Firestore');
					return;
				});
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send('User does not exist');
				return;
			}
			res.status(400).send('Something went wrong!');
			return;
		});
});

router.post('/delivery', async (req, res) => {
	// Update a package to received for given Boxi ID
	const { userId, boxiId, trackingNumber } = req.body;

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

	// update the package as received by boxi
	const updatedPackageStatus = {
		is_delivered: true,
		time: admin.firestore.Timestamp.now()
	};

	try {
		let boxiStatus = boxiDoc.data();
		boxiStatus['packages'][trackingNumber] = updatedPackageStatus;
		await boxiRef.set(boxiStatus);
	} catch (err) {
		res.status(400).send('Failed updating package status');
		return;
	}

	res.status(200).send('Success!');
	return;
});

router.post('/unlock', async (req, res) => {
	// Lock/Unlock a Boxi
	const { userId, boxiId, isUnlocking } = req.body;

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

	// update the boxi status to lock/unlock
	try {
		await boxiRef.update({ unlock_status: isUnlocking });
	} catch (err) {
		res.status(400).send('Failed to unlock boxi');
		return;
	}

	res.status(200).send('Success!');
	return;
});

router.get('/unlock-status', async (req, res) => {
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

	const lockStatus = boxiDoc.data()['unlock_status'];
	res.status(200).send({ status_code: 200, data: lockStatus, msg: 'Success!' });
	return;
});

router.post('/alarm', async (req, res) => {
	// Turning on/off alarm on a Boxi given Boxi ID
	const { userId, boxiId, isAlarming } = req.body;

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
		await boxiRef.update({ alarm_status: isAlarming });
	} catch (err) {
		res.status(400).send('Failed to post boxi alarm status');
		return;
	}

	res.status(200).send('Success!');
	return;
});

router.get('/alarm-status', async (req, res) => {
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

	const alarmStatus = boxiDoc.data()['alarm_status'];
	res.status(200).send({ status_code: 200, data: alarmStatus, msg: 'Success!' });
	return;
});

router.post('/post-ip', async (req, res) => {
	// Turning on/off alarm on a Boxi given Boxi ID
	const { userId, boxiId, ipAddr, port} = req.body;

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

	// update the ip of the box
	try {
		await boxiRef.set({ ip_addr: ipAddr, port: port });
	} catch (err) {
		console.log(err)
		res.status(400).send('Failed to post boxi ip');
		return;
	}

	res.status(200).send('Success!');
	return;
});



module.exports = router;
