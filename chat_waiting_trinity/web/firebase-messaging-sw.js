importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js');

firebase.initializeApp({
    apiKey: "AIzaSyB1C1R4sGF9SlylT2vhTETn_SlPLqj8W5w",
    authDomain: "chat-waiting-trinity.firebaseapp.com",
    databaseURL: "https://chat-waiting-trinity.firebaseio.com",
    projectId: "chat-waiting-trinity",
    storageBucket: "chat-waiting-trinity.appspot.com",
    messagingSenderId: "368032595776",
    appId: "1:368032595776:web:2327e906578ec6ae9b44a5",
});

const messaging = firebase.messaging();