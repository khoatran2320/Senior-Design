// Firebase setup
const auth = require('firebase-admin/auth');
const admin = require('firebase-admin');
const db = admin.firestore();
const PACKAGE_COLLECTION = 'user_packages';
const BOXI_COLLECTION = 'boxi';

/**
 * Check if firebase user exists
 * @param userId firebase userid
 * @param res express response obj
 * @returns boolean
 */
async function checkUserExist(userId, res) {
	try {
		await auth.getAuth().getUser(userId);
	} catch (err) {
		//unable to find user
		if (err['errorInfo']['code'] == 'auth/user-not-found') {
			res.status(400).send('User does not exist');
			return false;
		}
		res.status(400).send('Something went wrong!');
		return false;
	}

	return true;
}

/**
 * Check if firebase user owns boxi given boxId
 * @param userId firebase userid
 * @param boxiId boxiId
 * @param res express response obj
 * @returns boolean
 */
async function checkUserOwnsBox(userId, boxiId, res) {
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
		return false;
	}

	return userOwnsBox;
}

module.exports = {
	checkUserExist,
    checkUserOwnsBox
};
