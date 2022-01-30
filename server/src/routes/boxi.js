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
    auth.getAuth().getUser(userId)
        .then(async (user) => {
            //user found, verify user owns box
            let userOwnsBox = false;
            const sshot = await db.collection(COLLECTION_NAME).doc(userId).collection('boxes').get();
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
            const snapshot = await db.collection(COLLECTION_NAME).doc(userId).collection('trackings').get();
            snapshot.forEach((doc) => {
                if (doc.id == trackingNumber) {
                    userOwnsPackage = true;
                }
            });
            if (userOwnsPackage) {
                //check package status
                pkgeAPI.getPackage(trackingNumber)
                    .then((pkgeInfo) => {
                        //validate if package is on the way
                        // 3: package is in transit 
                        // 4: package is pending delivery
                        if (pkgeInfo['status'] == 3 || pkgeInfo['status'] == 4) {
                            res.status(200).send('Package expected!');
                            return;
                        }
                        else {
                            //package has not been shipped, has been delivered, or otherwise not expected to be delivered soon
                            res.status(400).send('Package not expected!');
                            return;
                        }
                    })
                    .catch((e) => {
                        res.status(400).send(e);
                        return;
                    })
            }
            else {
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
})

router.post('/add-box', (req, res) => {
    const { userId, boxiId } = req.query;

    if (!userId) {
        res.status(400).send('Requires a user ID!');
        return;
    }
    if (!boxiId) {
        res.status(400).send('Requires a box ID!');
        return;
    }
    //check to see if user exists
    auth.getAuth().getUser(userId)
        .then((user) => {
            //user exists, add reference to box id
            const docRef = db.collection(COLLECTION_NAME).doc(userId).collection('boxes').doc(boxiId);
            docRef.set({
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
                })
        })
        .catch((err) => {
            //unable to find user
            if (err['errorInfo']['code'] == 'auth/user-not-found') {
                res.status(400).send('User does not exist');
                return;
            }
            res.status(400).send('Something went wrong!');
            return;
        })

})
module.exports = router;
