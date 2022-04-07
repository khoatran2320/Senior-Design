
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// const { sendLockNotification } = require("../notifications/lock_notification");


exports.alarmOrLockStatusChange = functions.firestore.document('boxi/{boxiId}')
	.onUpdate(async (snapshot, context) => {
		console.log("alarmOrLockStatusChange detected");

    const oldSnap = snapshot.before.data(); // previous document
    const newSnap = snapshot.after.data(); // current document

		if (oldSnap.unlock_status != newSnap.unlock_status) {
			// backend sends notification to user
				// “BOXi has been unlocked via the barcode scanner!”
				// “BOXi has been locked!”
			// backend sends data to frontend silently so that frontend updates lock icon
				// Lock Model

			const boxiId = context.params.boxiId;
			// sendLockNotification(newSnap.unlock_status, boxiId);
			console.log('Detected unlock_status change! ', boxiId);
		}

		if (oldSnap.alarm_is_ringing != newSnap.alarm_is_ringing
			&& newSnap.alarm_is_ringing) {

			// Send notification to user
		}

		return;
	});
