const express = require('express');
const app = express();
const port = 3000;
const axios = require('axios');
var pkgeAPI = require('./pkge_api');

const cors = require('cors');
const { response } = require('express');
app.use(cors());
app.use(express.json());

var admin = require('firebase-admin');
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const auth = require('firebase-admin/auth');

var serviceAccount = require('./boxi_key.json');
admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
});
const db = getFirestore();
const COLLECTION_NAME = 'user_packages';

app.get('/', (req, res) => {
	res.send('Hello World!');
});

/* ***** get_package_info  *****
    desc: get the details of a package
    inputs: 
      trackingNumber: tracking number of the package to retrieve information
    outputs: 
      code 200: succesfully retrieved the information 
      code 400: unable to get package information
*/

app.get('/package', (req, res) => {
	const { trackingNumber } = req.query;

	if (trackingNumber == undefined) {
		res.status(400).send('Requires a tracking number!');
	}
	axios({
		method: 'get', //you can set what request you want to be
		url: 'https://api.pkge.net/v1/packages?',
		params: { trackNumber: trackingNumber },
		headers: {
			Accept: 'application/json',
			'X-Api-Key': process.env.PKGE_API_KEY
		}
	})
		.then((response) => {
			res.status(200).send(JSON.stringify(response.data.payload));
		})
		.catch((err) => {
			res.status(400).send(JSON.stringify(err.response.data));
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

app.post('/package', (req, res) => {
	const { trackingNumber, userId } = req.query;
	if (!trackingNumber) {
		res.status(400).send('Requires a tracking number!');
	}
	if (!userId) {
		res.status(400).send('Requires a user ID!');
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
						.doc(req.query.userId)
						.collection('trackings')
						.doc(trackingNumber);
					docRef
						.set({
							status: pkgeAPI.deliveryStatus[0]
						})
						.then((r) => {
							// everything went smoothly
							res.status(200).send('Success!');
						})
						.catch((e) => {
							// unable to write to firestore
							res.status(400).send('Unable to write to Firestore');
						});
				})
				.catch((e) => {
					//unable to add package to PKGE
					res.status(400).send(e);
				});
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send('User does not exist');
			}
			res.status(400).send('Something went wrong!');
		});
});

app.post('/package', (req, res) => {
	const { trackingNumber, userId } = req.query;

	if (trackingNumber == undefined) {
		res.status(400).send('Requires a tracking number!');
	}
	if (userId == undefined) {
		res.status(400).send('Requires a user ID!');
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
							status: pkgeAPI.deliveryStatus[0]
						})
						.then((r) => {
							// everything went smoothly
							res.status(200).send('Success!');
						})
						.catch((e) => {
							// unable to write to firestore
							res.status(400).send('Unable to write to Firestore');
						});
				})
				.catch((e) => {
					//unable to add package to PKGE
					res.status(400).send(e);
				});
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send('User does not exist');
			}
			res.status(400).send('Something went wrong!');
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

app.delete('/package', (req, res) => {
	const trackingNumber = req.query.trackingNumber;
	if (!trackingNumber) {
		res.status(400).send('Requires a tracking number!');
	}

	axios({
		method: 'delete',
		url: 'https://api.pkge.net/v1/packages?',
		params: {
			trackNumber: trackingNumber
		},
		headers: {
			Accept: 'application/json',
			'X-Api-Key': process.env.PKGE_API_KEY
		}
	})
		.then((response) => {
			res.status(200).send(JSON.stringify(response.data));
		})
		.catch((err) => {
			res.status(404).send('Package with tracking number not found!');
		});
});

app.delete('/package', (req, res) => {
	const { trackingNumber } = req.query;

	if (trackingNumber == undefined) {
		res.status(400).send('Requires a tracking number!');
	}

	axios({
		method: 'delete',
		url: 'https://api.pkge.net/v1/packages?',
		params: {
			trackNumber: trackingNumber
		},
		headers: {
			Accept: 'application/json',
			'X-Api-Key': process.env.PKGE_API_KEY
		}
	})
		.then((response) => {
			res.status(200).send(JSON.stringify(response.data));
		})
		.catch((err) => {
			res.status(404).send('Package with tracking number not found!');
		});
});

/* ***** get_packages  *****
    desc: get a list of packages that are currently being tracked
    inputs: 
      
    outputs: 
      code 200: succesfully returns the list of packages
*/

app.get('/packages', (req, res) => {
	const { userId } = req.query;

	if (!userId) {
		res.status(400).send('Requires a user ID!');
	}

	auth
		.getAuth()
		.getUser(userId)
		.then((user) => {
			pkgeAPI
				.getPackages()
				.then(async (pkges) => {
					let packages = {};
					const snapshot = await db.collection(COLLECTION_NAME).doc(userId).collection('trackings').get();
					for (const pkge in pkges) {
						snapshot.forEach((doc) => {
							if (doc.id == pkges[pkge]['track_number']) {
								packages[pkges[pkge]['track_number']] = pkges[pkge];
							}
						});
					}
					res.status(200).send(packages);
				})
				.catch((e) => {
					res.status(400).send(e);
				});
		})
		.catch((err) => {
			//unable to find user
			if (err['errorInfo']['code'] == 'auth/user-not-found') {
				res.status(400).send('User does not exist');
			}
			res.status(400).send('Something went wrong!');
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

app.post('/update_package', (req, res) => {
	const trackingNumber = req.query.trackingNumber;

	if (!trackingNumber) {
		res.status(400).send('Requires a tracking number!');
	}

	axios({
		method: 'post',
		url: 'https://api.pkge.net/v1/packages/update?',
		params: {
			trackNumber: trackingNumber
		},
		headers: {
			Accept: 'application/json',
			'X-Api-Key': process.env.PKGE_API_KEY
		}
	})
		.then((response) => {
			res.status(200).send('Retrieving updated information on package...');
		})
		.catch((err) => {
			if (err.response.status == 404) {
				res.status(404).send('Package with trracking number not found!');
			} else {
				res.status(400).send(err.response.data);
			}
		});
});

app.listen(port, () => {
	console.log(`Example app listening at http://localhost:${port}`);
});
