const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//https://firebase.google.com/docs/functions/firestore-events

exports.newChatMessage = functions.firestore.document('users/{userId}/chatRooms/{roomId}')
    .onWrite((change, context) => {
        if (change.after.data().chatRoomType === '1on1') {
            const payload = { "notification": { "body": `${change.after.data().lastMessage}`, "title": `${change.after.data().chatUserName}` }, "data": { "click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done" } };
            return admin.messaging().sendToTopic(context.params.userId, payload);
        }
        return null;
    });

exports.requestGuestChat = functions.firestore.document('users/{userId}/chatRooms/{roomId}')
    .onCreate((snapshot, context) => {

        if (snapshot.data().chatRoomType === 'withGuest') {
            console.log('guest notification');

            const payload = { "notification": { "body": "Plase answer ASAP.", "title": "Guest requested a chat" }, "data": { "click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done" } };
            return admin.messaging().sendToTopic(context.params.userId, payload);
        }
        return null;

    });