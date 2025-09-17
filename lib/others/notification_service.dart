import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

initFCM()async{
await _firebaseMessaging.requestPermission();
final fcmToken = await _firebaseMessaging.getToken();
print('FCM Token: $fcmToken');

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  print('A new onMessageOpenedApp event was published!');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});

FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Received a message while in the foreground!');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});

// FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//   print('Handling a background message: ${message.messageId}');
// });

// FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//   print('Handling a background message: ${message.messageId}');
// }); 


}}