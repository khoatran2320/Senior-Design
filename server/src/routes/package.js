// Express Setup
const express = require('express');
const router = express.Router();

// PKGE 3rd Party API
const pkgeAPI = require('../pkge_api');

// Firebase setup
const auth = require('firebase-admin/auth');
const admin = require('firebase-admin');
const db = admin.firestore();
const COLLECTION_NAME = 'user_packages';

/* ***** get_package_info  *****
	desc: get the details of a package
	inputs:
	  trackingNumber: tracking number of the package to retrieve information
	outputs:
	  code 200: succesfully retrieved the information
	  code 400: unable to get package information
*/
router.get('/', (req, res) => {
	const { trackingNumber, userId } = req.query;

	if (!trackingNumber) {
		res.status(400).send({ status_code: 400, msg: 'Requires a tracking number!' });
		return;
	}
	if (!userId) {
		res.status(400).send({ status_code: 400, msg: 'Requires a user ID!' });
		return;
	}
	auth
		.getAuth()
		.getUser(userId)
		.then(async (user) => {
			let userOwnsPackage = false;
			const snapshot = await db.collection(COLLECTION_NAME).doc(userId).collection('trackings').get();
			snapshot.forEach((doc) => {
				if (doc.id == trackingNumber) {
					userOwnsPackage = true;
				}
			});
			if (userOwnsPackage) {
				pkgeAPI
					.getPackage(trackingNumber)
					.then((pkgeInfo) => {
						res.status(200).send({ status_code: 200, data: pkgeInfo, msg: 'Success!' });
					})
					.catch((e) => {
						res.status(400).send({ status_code: 400, msg: e.message });
					});
			} else {
				res.status(400).send({ status_code: 400, msg: 'Package does not exist' });
			}
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send({ status_code: 400, msg: 'User does not exist' });
			}
			res.status(400).send({ status_code: 400, msg: 'Something went wrong!' });
		});
});

/* ***** add_package  *****
	desc: add a package to start tracking. 3 step mechanism
	  1. Validate user
	  2. Add package to start tracking in PKGE
	  3. Add package reference to user in Firestore
	inputs:
	  trackingNumber: tracking number of the package to track
	outputs:
	  code 200: successfully adds the new package
	  code 400: unable to add package, more error codes and error messages in the return response
*/
router.post('/', (req, res) => {
	const { trackingNumber, userId, itemName, merchantName, orderNumber } = req.body;
	if (!trackingNumber) {
		res.status(400).send({ status_code: 400, msg: 'Requires a tracking number!' });
		return;
	}
	if (!userId) {
		res.status(400).send({ status_code: 400, msg: 'Requires a user ID!' });
		return;
	}

	//check to see if user exists
	auth
		.getAuth()
		.getUser(userId)
		.then((user) => {
			//user exists, proceed to add package to PKGE
			pkgeAPI
				.addPackage(trackingNumber)
				.then((r) => {
					// package added to PKGE, proceed to make reference in firestore db
					const docRef = db
						.collection(COLLECTION_NAME)
						.doc(userId)
						.collection('trackings')
						.doc(trackingNumber);
					docRef
						.set({
							status: pkgeAPI.deliveryStatus[0],
							itemName: itemName,
							merchantName: merchantName,
							orderNumber: orderNumber
						})
						.then((r) => {
							// everything went smoothly
							res.status(200).send({ status_code: 200, msg: 'Success!' });
							return;
						})
						.catch((e) => {
							// unable to write to firestore
							res.status(400).send({ status_code: 400, msg: 'Unable to write to Firestore' });
						});
				})
				.catch((e) => {
					// Unable to add package to PKGE
					res.status(400).send({ status_code: 400, msg: JSON.parse(e).payload });
				});
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send({ status_code: 400, msg: 'User does not exist' });
				return;
			}
			res.status(400).send({ status_code: 400, msg: 'Something went wrong!' });
		});
});

/* ***** delete_package  *****
	desc: delete a package that is currently being tracked
	inputs:
	  trackingNumber: tracking number of the package to delete
	outputs:
	  code 200: successfully deleted package
	  code 404: package with provided tracking number not found
*/
router.delete('/', (req, res) => {
	const { trackingNumber, userId } = req.query;

	if (!userId) {
		res.status(400).send({ status_code: 400, msg: 'Requires a user ID!' });
		return;
	}
	if (!trackingNumber) {
		res.status(400).send({ status_code: 400, msg: 'Requires a tracking number!' });
		return;
	}
	auth
		.getAuth()
		.getUser(userId)
		.then(async (user) => {
			let userOwnsPackage = false;
			const snapshot = await db.collection(COLLECTION_NAME).doc(userId).collection('trackings').get();
			snapshot.forEach((doc) => {
				if (doc.id == trackingNumber) {
					userOwnsPackage = true;
				}
			});

			if (userOwnsPackage) {
				const ret = await db
					.collection(COLLECTION_NAME)
					.doc(userId)
					.collection('trackings')
					.doc(trackingNumber)
					.delete();
				pkgeAPI
					.deletePackage(trackingNumber)
					.then((response) => {
						res.status(200).send({ status_code: 200, data: response, msg: 'Success!' });
						return;
					})
					.catch((e) => {
						res.status(400).send({ status_code: 400, msg: e.message });
						return;
					});
			} else {
				res.status(400).send({ status_code: 400, msg: 'Package does not exist' });
				return;
			}
		})
		.catch((err) => {
			//unable to find user
			try {
				if (err['errorInfo']['code'] == 'auth/user-not-found') {
					res.status(400).send({ status_code: 400, msg: 'User does not exist' });
					return;
				}
			} catch (err) {
				res.status(400).send({ status_code: 400, msg: 'Something went wrong!' });
				return;
			}
			res.status(400).send({ status_code: 400, msg: 'Something went wrong!' });
			return;
		});
});

/* ***** get_packages  *****
	desc: get a list of packages that are currently being tracked
	inputs:

	outputs:
	  code 200: succesfully returns the list of packages
*/
router.get('/all', (req, res) => {
	const { userId } = req.query;

	if (!userId) {
		res.status(400).send({ status_code: 400, msg: 'Requires a user ID!' });
		return;
	}

	packageCount = 0;

	auth
		.getAuth()
		.getUser(userId)
		.then((user) => {
			pkgeAPI
				.getPackages()
				.then(async (pkges) => {
					let packages = [];
					const snapshot = await db.collection(COLLECTION_NAME).doc(userId).collection('trackings').get();
					for (const i in pkges) {

						snapshot.forEach((doc) => {
							if (doc.id == pkges[i]['track_number']) {

								packages[packageCount] = {
									trackingNum: doc.id,
									itemName: doc._fieldsProto.itemName.stringValue,
									merchantName: doc._fieldsProto.merchantName.stringValue,
									trackingInfo: pkges[i]
								};

								packageCount += 1;
							}
						});
					}

					res.status(200).send({ status_code: 200, data: packages, msg: 'Success!' });
					return;
				})
				.catch((e) => {
					res.status(400).send({ status_code: 400, msg: e.message });
					return;
				});
		})
		.catch((err) => {
			// Unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send({ status_code: 400, msg: 'User does not exist' });
			}
			res.status(400).send({ status_code: 400, msg: 'Something went wrong!' });
		});
});

/* ***** update_package  *****
	desc: updates the package to get the latest checkpoints and status
	inputs:
	  trackingNumber: tracking number of the package to update
	outputs:
	  code 200: successfully queues the update process. This update process may take a while and does not immediately update the status of the package
	  code 404: package with provided tracking number not found
	  code 400: unable to update package, more information is sent back to the client
		903	Failed to update the package. Not enough time has passed since the last update, or the package has already been delivered. Followed by the date of the next possible update in 'payload' if an update is possible
		909	Failed to update the package. The maximum number of packages allowed is currently being updated. Wait for the next package to complete the update and repeat the request
		910	Package update progress check requests are too frequent. Repeat the request later.
*/
router.post('/update', (req, res) => {
	const { trackingNumber, userId } = req.body;

	if (!userId) {
		res.status(400).send({ status_code: 400, msg: 'Requires a user ID' });
		return;
	}
	if (!trackingNumber) {
		res.status(400).send({ status_code: 400, msg: 'Requires a tracking number!' });
		return;
	}

	auth
		.getAuth()
		.getUser(userId)
		.then(async (user) => {
			let userOwnsPackage = false;
			const snapshot = await db.collection(COLLECTION_NAME).doc(userId).collection('trackings').get();
			snapshot.forEach((doc) => {
				if (doc.id == trackingNumber) {
					userOwnsPackage = true;
				}
			});
			if (userOwnsPackage) {
				pkgeAPI
					.updatePackage(trackingNumber)
					.then((updateRes) => {
						res.status(200).send({ status_code: 200, msg: 'Success!', data: updateRes });
						return;
					})
					.catch((e) => {
						res.status(400).send({ status_code: 400, msg: e.message });
						return;
					});
			} else {
				res.status(400).send({ status_code: 400, msg: 'Package does not exist' });
				return;
			}
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send({ status_code: 400, msg: 'User does not exist' });
				return;
			}
			res.status(400).send({ status_code: 400, msg: 'Something went wrong!' });
			return;
		});
});

module.exports = router;
