import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_three/models/message.dart';
import 'package:top_three/models/user.dart';
import 'package:top_three/screens/authentificate/authentificate.dart';
import 'package:top_three/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
       onMessage: (Map<String, dynamic> message) async {
         print("onMessage: $message");
         // _showItemDialog(message);
         final notification = message['notification'];
         setState(() {
           messages.add(Message(
             title: notification['title'], body: notification['body']
           ));
         });
       },
       // onBackgroundMessage: myBackgroundMessageHandler,
       onLaunch: (Map<String, dynamic> message) async {
         print("onLaunch: $message");
         // _navigateToItemDetail(message);
       },
       onResume: (Map<String, dynamic> message) async {
         print("onResume: $message");
         // _navigateToItemDetail(message);
       },
     );
     _firebaseMessaging.requestNotificationPermissions(
       const IosNotificationSettings(sound: true, badge: true, alert: true)
     );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print (user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}