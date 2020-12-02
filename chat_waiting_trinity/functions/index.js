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

exports.myFunction = functions.firestore.document('users/{documents}')
    .onCreate((snapshot, context) => {
        // console.log(snapshot.data());
        return admin.messaging().sendToTopic('users', {
            notification: {
                title: snapshot.data().username,
                body: 'new user created',
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        });


        // return;
    });

exports.requestGuestChat = functions.firestore.document('users/{userId}/chatRooms/{roomId}')
    .onCreate((snapshot, context) => {
        if (context.params.userId === 'M0clGRrBRMQSfQykuyA72WwHLgG2') {
            if (snapshot.data().chatRoomType === 'withGuest') {
                console.log('guest notification');

                const payload = {"notification": {"body": "Plase answer ASAP.","title": "Guest requested a chat"}, "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}};

                return admin.messaging().sendToTopic('chatGuest', payload);


                
            }
          
        }
        else{
        console.log('chat notification');
        
        const payload = {"notification": {"body": `${snapshot.data().lastMessage}` ,"title": `${snapshot.data().chatUserName}`}, "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}};

        return admin.messaging().sendToTopic('chats', payload);
        }
    });