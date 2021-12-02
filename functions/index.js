const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const fcm = admin.messaging();

exports.addStaff = functions.https.onCall((data, context) => {
  functions.logger.log("Adding Student Started");
  const returnRecord = addUser(data.profile.email, data.profile.name, {});
  return returnRecord;
});

async function addUser(email, displayName, claims) {
  functions.logger.log("Add User Triggered");
  let returnRecord;
  try {
    returnRecord = admin.auth().createUser({
      email: email,
      disabled: false,
      password: "12345678",
      displayName: displayName,
    }).then((userRecord) => {
      admin.auth().setCustomUserClaims(userRecord.uid, claims).then(() => returnRecord = userRecord, () => console.log("Rejected"));
      return userRecord;
    }).then();
    returnRecord = await returnRecord;
  } catch (error) {
    return error;
  }
  return returnRecord;
}

exports.myFunction = functions.firestore
  .document("Announcements/{content}")
  .onCreate((snapshot, context) => {
    functions.logger.log(snapshot);
    const notify = snapshot.data();
    functions.logger.log(notify);
    return fcm.sendToTopic("Announcement", {
      notification: {
        title: notify.title, body: notify.description, clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });

exports.myComplaints = functions.firestore
  .document("Complaints/{content}")
  .onCreate((snapshot, context) => {
    functions.logger.log(snapshot);
    const notify = snapshot.data();
    functions.logger.log(notify);
    return fcm.sendToTopic("Complaint", {
      notification: {
        title: notify.title, body: notify.description, clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });
exports.sendNotification = functions.https.onCall(async (data, context) => {
  const token = data.fcm;
  functions.logger.log("function called");
  functions.logger.log(data);
  functions.logger.log(token);
  if (token != null) {
    return await fcm.sendToDevice(token, {
      notification: {
        title: "Quarantine", body: "You have been quarantined", clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    }).catch((error) => {
      functions.logger.log(error);
    });
  } else {
    return;
  }
});


