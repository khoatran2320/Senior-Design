const admin = require("firebase-admin");


exports.sendLockNotification = async (isUnlocked, userId) => {

	console.log('Sending notification about unlock_status change');

	let tokens;

	try {
		const userTokensDoc = await admin.firestore().collection("user_tokens").doc(userId).get();
		tokens = userTokensDoc.data()['tokens'];
	} catch (error) {
		console.log('sendLockNotification: Error with getting user tokens\n', error);
	}


	let title = "";
	let body = "";

	if (isUnlocked) {
		title = "Unlocked!";
		body = "Your BOXi has been unlocked!";
	} else {
		title = "Locked!";
		body = "Your BOXi has been relocked!";
	}

	admin.messaging().sendMulticast({
	  tokens: tokens,
	  notification: {
	    title: title,
	    body: body
	  },
		data: {
    	click_action: "FLUTTER_NOTIFICATION_CLICK",
			unlock_status: isUnlocked.toString()
		}
	})
	.then((_) => {
		console.log('sendLockNotification: success!')
	}).catch((error) => {
		console.log('sendLockNotification: Error with sending the notification\n', error);
	});
}
