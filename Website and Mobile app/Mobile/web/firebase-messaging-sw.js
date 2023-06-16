importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
   const firebaseConfig = {
    apiKey: "AIzaSyCnCR8XhWteUkvoV2viDljeGoAyGs7MD4g",
    authDomain: "my-i-pond.firebaseapp.com",
    databaseURL: "https://my-i-pond-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "my-i-pond",
    storageBucket: "my-i-pond.appspot.com",
    messagingSenderId: "841028351892",
    appId: "1:841028351892:web:b45ea2ca068cd41d60c181",
    measurementId: "G-3NN3HVWK69"
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
